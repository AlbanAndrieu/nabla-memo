SELECT schemaname,
       tablename,
       policyname,
       permissive,
       roles,
       cmd,
       qual,
       with_check
FROM pg_policies
ORDER BY schemaname, tablename, policyname;

SELECT n.nspname AS schemaname,
c.relname AS tablename,
pol.polname AS policyname,
	CASE
		WHEN pol.polpermissive THEN 'PERMISSIVE'::text
		ELSE 'RESTRICTIVE'::text
	END AS permissive,
	CASE
		WHEN pol.polroles = '{0}'::oid[] THEN string_to_array('public'::text, ''::text)::name[]
		ELSE ARRAY( SELECT pg_authid.rolname
		   FROM pg_authid
		  WHERE pg_authid.oid = ANY (pol.polroles)
		  ORDER BY pg_authid.rolname)
	END AS roles,
	CASE pol.polcmd
		WHEN 'r'::"char" THEN 'SELECT'::text
		WHEN 'a'::"char" THEN 'INSERT'::text
		WHEN 'w'::"char" THEN 'UPDATE'::text
		WHEN 'd'::"char" THEN 'DELETE'::text
		WHEN '*'::"char" THEN 'ALL'::text
		ELSE NULL::text
	END AS cmd,
pg_get_expr(pol.polqual, pol.polrelid) AS qual,
pg_get_expr(pol.polwithcheck, pol.polrelid) AS with_check
FROM pg_policy pol
 JOIN pg_class c ON c.oid = pol.polrelid
 LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
 order by tablename asc;

DO $$
DECLARE
    _policy_name text := 'NAME_OF_THE_POLICY';
    _table_name text := 'NAME OF THE TABLE';
    _existing_condition text;
    _new_roles text[] := ARRAY['ROLE_1_TO ADD', '..', 'ROLE_n_TO_ADD'];
    _current_roles oid[];
    _all_roles oid[];
    _new_policy_sql text;
BEGIN
    -- Retrieve the existing policy condition and roles
    SELECT pg_get_expr(pol.polqual, pol.polrelid), pol.polroles INTO _existing_condition, _current_roles
    FROM pg_policy pol
    WHERE pol.polname = _policy_name AND pol.polrelid = (SELECT oid FROM pg_class WHERE relname = _table_name);

    -- Convert role names to OIDs and merge with existing roles
    SELECT array_agg(rol.oid) FROM pg_roles rol WHERE rol.rolname = ANY(_new_roles) INTO _all_roles;
    _all_roles := _current_roles || _all_roles;

    -- Generate the SQL for recreating the policy with updated roles
    _new_policy_sql := format(
        'DROP POLICY IF EXISTS %I ON %I; ' ||
        'CREATE POLICY %I ON %I ' ||
        'AS PERMISSIVE ' ||
        'FOR ALL ' ||
		'TO %s ' ||
        'USING (%s);',
        _policy_name, _table_name, _policy_name, _table_name,
        array_to_string(array(select rolname from pg_roles where oid = any(_all_roles)), ', '),
        _existing_condition
    );

    -- Output the generated SQL
    RAISE NOTICE 'Generated SQL: %', _new_policy_sql;
END $$;

-- A user into the row security level must no be able to see any row from these following sql queries
select * from decision_translation where translatable_id in (
	select id from decision where log_versioning_and_trace_enabled is false
);

select * from opinion_translation where translatable_id in (
	select id from opinion where log_versioning_and_trace_enabled is false
);

select * from case_other_document_translation where translatable_id in (
	select id from case_other_document where log_versioning_and_trace_enabled is false
);

select * from decision_article_element_translation where translatable_id in (
	select dae.id
	from decision d
	left join decision_level dl on dl.decision_id = d.id
	left join decision_article da on da.decision_level_id = dl.id
	left join decision_article_element dae on dae.decision_article_id = da.id
	where d.log_versioning_and_trace_enabled is false and dae.id is not null
	limit 100
);

-- You can impersonate the role with the following
SET ROLE aandrieu;
SELECT current_user;
RESET ROLE;
