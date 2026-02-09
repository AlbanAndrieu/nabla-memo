#!/bin/bash
set -xv

# https://www.neosoft.fr/nos-publications/blog-tech/liquibase-et-le-versioning-de-base-de-donnees/

mvn archetype:generate -DgroupId=fr.patouche.soat -DartifactId=sample-liquibase -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

exit 0
