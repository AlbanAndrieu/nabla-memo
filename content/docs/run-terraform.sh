#!/bin/bash
set -xv

# brew install terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

sudo apt update && sudo apt install terraform

apt policy terraform
# sudo apt install terraform=1.9.5
sudo apt install terraform

terraform --version
terraform -install-autocomplete

cd nabla-servers-bower-sample
terraform init

# Echo organisation : Banbou - https://github.com/Banbou
# terraform apply
terraform apply -var 'key_name=terraform' -var 'public_key_path=~/.ssh/id_rsa.pub' -var 'provider.github.organization=Banbou' -var "provider.github_token=${GITHUB_TOKEN}"

terraform plan -lock=true -target="module.s3_se_es_backup"

# terraform plan -lock=true --target cloudflare_ruleset.nablacom_zone_level_managed_waf
terraform plan -lock=true --target cloudflare_ruleset.lexsportivatech_zone__custom_firewall

terraform plan -lock=true --target cloudflare_ruleset.lexsportivatech_zone_level_managed_waf

terraform plan -lock=true --target cloudflare_logpush_job.datadog_http_requests_lexsportiva_tech
terraform apply -lock=true --target cloudflare_logpush_job.datadog_http_requests_lexsportiva_tech

terraform plan -lock=true --target cloudflare_ruleset.api_rl_lexsportiva_tech
terraform plan -lock=true --target cloudflare_ruleset.custom_fields_logging_lexsportiva_tech

terraform plan -lock=true --target cloudflare_ruleset.transform_modify_request_headers_lexsportiva_tech
terraform apply -lock=true --target cloudflare_ruleset.transform_modify_request_headers_lexsportiva_tech

terraform plan -lock=true --target cloudflare_ruleset.transform_modify_response_headers_lexsportiva_tech
terraform plan -lock=true --target cloudflare_ruleset.transform_modify_response_headers_customer_ip_lexsportiva_com

terraform plan -var-file=".env.dev.tfvars" -lock=true -target=ovh_cloud_project_user.write_user_assistant_user_upload
terraform show

terraform state list
terraform state list "ovh_cloud_project_user.s3_admin_user"
# terraform state pull "ovh_cloud_project_user.s3_admin_user"
terraform state pull > terraform.tfstate
terraform state rm "ovh_cloud_project_user.s3_admin_user"

terraform state list cloudflare_page_rule.lexsportivatech_jc_page_rule_ttl_by_status
terraform state rm cloudflare_page_rule.lexsportivatech_jc_page_rule_ttl_by_status

terraform state list | grep 'module.s3_se_es_backup' | awk '{print "--target="$0}' | xargs | xargs -o terraform plan --destroy

# See https://learn.hashicorp.com/tutorials/terraform/state-import?in=terraform/state&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS

git clone https://github.com/hashicorp/learn-terraform-import.git
cd learn-terraform-import
terraform init -upgrade

docker ps --filter "name=nabla-servers-symfony-sample_php"

# See https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa

#terraform workspace new test
terraform workspace new prod
terraform workspace new uat
terraform workspace new dev
#terraform workspace list
terraform workspace select uat

terraform workspace show

go install github.com/aquasecurity/tfsec/cmd/tfsec@latest
tfsec .
go install github.com/minamijoyo/tfupdate@latest
tfupdate --version
tfupdate terraform -r ./

terraform providers lock

pip install checkov
checkov -d . --skip-check CKV_DOCKER_8
checkov --skip-path ansible/roles/ --soft-fail
pre-commit run terraform_checkov
pre-commit run terraform_fmt --all-files

pre-commit run terraform_tfsec
tfsec . -m HIGH --config-file tfsec.yml

# go install github.com/hashicorp/hcl/v2/cmd/hclfmt@latest

# https://thenewstack.io/install-terraform-and-the-gaia-web-ui-on-ubuntu-server-22-04/
sudo nano /etc/hosts
# Add gaia to localhost
podman-compose up --force-recreate -d
# admin/admin123

# https://github.com/tenable/terrascan
# brew install terrascan
# docker run tenable/terrascan
#
# terrascan scan -t aws -v --skip-rules="AC_AWS_0214" # --scan-rules="AWS.S3Bucket.DS.High.1043"
# terrascan scan -t aws -v --skip-rules="AC_AWS_0214,AC_AWS_0148" --severity="MEDIUM" --config-path ./terrascan.yaml
brew install tflint

terraform console
# enter code
module.gra1setest1.instance_ips[count.index]

# https://regula.dev/integrations/pre-commit.html
# brew install regula

# change dynamodb object state version

# Change DynamoDB jusmundi-terraform-gitlab/vault/prod.tfstate-md5 Digest 2d4d6e827849c6a2fab47481a9496eb2
# In the UI https://eu-west-3.console.aws.amazon.com/dynamodbv2/home?region=eu-west-3#item-explorer?maximize=true&operation=SCAN&table=jusmundi-terraform-gitlab-locks
# Explore items
# Get the keys
# By Amazon S3
# https://eu-west-3.console.aws.amazon.com/s3/object/jusmundi-terraform-gitlab?region=eu-west-3&bucketType=general&prefix=vault/prod.tfstate
# By Entity tag (Etag) 0f95f1ee16269eee9ef0b01b33f80fe0
# New jusmundi-terraform-gitlab/vault/prod.tfstate-md5 Digest 0f95f1ee16269eee9ef0b01b33f80fe0

# OR Amazon S3 Buckets -> jusmundi-terraform -> cloudflare-record/ -> terraform.tfstate
# get the value 171bbaa466dbc0eb4be6c1da40863e43
# Then go to dynamo DB
# Explore items
# Get the keys
# replace  Stored checksum: 7292e685b1d29324161bc09b0360d362 by Calculated checksum: 171bbaa466dbc0eb4be6c1da40863e43

terraform refresh

# terraform init -backend-config="key=vault/prod.tfstate" -reconfigure

terraform force-unlock <LOCK_ID>

exit 0
