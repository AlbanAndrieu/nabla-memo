#!/bin/bash
set -xv

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

sudo snap remove aws-cli
pipx uninstall awscli

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

/usr/local/bin/aws --version

rm -Rf aws/ awscliv2.zip

# URL https://172728779084.signin.aws.amazon.com/console
# User 172728779084

ll ~/.aws/credentials

# See https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/cli-configure-quickstart.html
aws configure
#echo $AWS_ACCESS_KEY_ID_JM
#echo $AWS_SECRET_ACCESS_KEY
#eu-west-3
#json

ll ~/.aws/config

unset AWS_PROFILE
aws iam list-users

aws s3 ls

#https://help.ubuntu.com/community/EC2StartersGuide
sudo apt-get install ec2-api-tools
#copy key pair and ceritificat to
scp * albandri@albandri:.ec2
cd .ec2
chmod go-rwx ~/.ec2/*.pem

gedit .bashrc
#add
export EC2_KEYPAIR=albandri # name only, not the file name
export EC2_URL=https://ec2.${AWS_DEFAULT_REGION}.amazonaws.com
export EC2_PRIVATE_KEY=$HOME/.ec2/pk-FMQ27HNLF2PVMPVL7MPWHEY5GWDKDOT2.pem
export EC2_CERT=$HOME/.ec2/cert-FMQ27HNLF2PVMPVL7MPWHEY5GWDKDOT2.pem

aws ec2 describe-instances --profile  terraform

source .bashrc
#test
ec2-describe-images -o self -o amazon

#NOK ssh Public DNS: ec2-54-213-181-235.us-west-2.compute.amazonaws.com
Public DNS: ec2-54-213-168-125.us-west-2.compute.amazonaws.com

54.213.168.125

cd ~/.ec2
chmod 600 albandri.pem
ssh -i /workspace/users/albandri10/.ec2/albandri.pem ubuntu@ec2-54-200-87-169.us-west-2.compute.amazonaws.com

ec2-describe-images -o self -o amazon
ec2-describe-instances
ec2-run-instances ami-xxxxx -k ${EC2_KEYPAIR} -t <instance type>

#Webmin install complete. You can now login to https://ip-172-31-29-239:10000/
#sudo apt-get install ntp autofs perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python subversion cvs tomcat7 git maven wget curl smartmontools mon cmake scons maven ssmtp mailutils
#
#wget http://home.nabla.mobi:8080/jnlpJars/jenkins-cli.jar
#java -jar jenkins-cli.jar -s http://home.nabla.mobi:8080/ help

ec2-authorize default -p 22
ec2-authorize default -p 25
ec2-authorize default -p 10000
ec2-authorize default -p 10001
ec2-authorize default -p 10002
ec2-authorize default -p 10003
ec2-authorize default -p 10004
ec2-authorize default -p 10005
ec2-authorize default -p 10006
ec2-authorize default -p 10007
ec2-authorize default -p 10008
ec2-authorize default -p 10009
ec2-authorize default -p 20000
ec2-authorize default -p 80
ec2-authorize default -p 443
ec2-authorize default -p 21
ec2-authorize default -p 20
ec2-authorize default -p 110
ec2-authorize default -p 143
ec2-authorize default -p 53
ec2-authorize default -p 53 -P udp

# See https://docs.aws.amazon.com/fr_fr/eks/latest/userguide/eksctl.html

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# See https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

# curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
# curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator.sha256
# openssl sha1 -sha256 aws-iam-authenticator
# chmod +x ./aws-iam-authenticator
# mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
# aws-iam-authenticator help

aws ecr get-login --no-include-email --region us-west-2

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 378612673110.dkr.ecr.eu-central-1.amazonaws.com/java-demo
export AWS_REGION=${AWS_REGION:-"eu-west-3"}
export OCI_REGISTRY="783876277037.dkr.ecr.eu-west-3.amazonaws.com"
export APP_IMAGE=alertapi
aws ecr get-login-password --region ${AWS_REGION:-"eu-west-3"} | docker login --username AWS --password-stdin ${OCI_REGISTRY:-"783876277037.dkr.ecr.eu-west-3.amazonaws.com"}
#783876277037.dkr.ecr.eu-west-3.amazonaws.com/jm-node:0.0.1-ba27ab2b
#docker tag petclinic-native:latest 378612673110.dkr.ecr.eu-central-1.amazonaws.com/java-demo
docker tag petclinic-native:latest nabla/petclinic-native
docker push nabla/petclinic-native:latest

./run-aws-tower.sh

# Generate rsa key https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ssh-unixes.html?icmpid=docs_acc_console_connect
ssh-keygen -t rsa -b 4096
chmod 600 config
chmod 600 *.pub
ssh git-codecommit.us-east-2.amazonaws.com

# See https://github.com/aquasecurity/cloudsploit

# Delete s3 bucket object

aws --endpoint-url https://s3.gra.io.cloud.ovh.net/ --profile s3-ovh s3 rm s3://tf-se-es-backup-uat --recursive --exclude "path/index-1"

aws --version
# No module named awscli_plugin_q
geany ~/.aws/config
# cli_dev_tools = awscli_plugin_q
pip3 install awscli-plugin-q
# https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-installing.html#command-line-installing-ubuntu
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo apt-get install -f
sudo dpkg -i amazon-q.deb

run-login() {
  api_key=$($awscli secretsmanager get-secret-value --secret-id 'my-secret-id' | jq -r '.SecretString' | jq -r ".MY_API_KEY")
  if [[ -z "$api_key" ]] ; then p-error "MY_API_KEY not found" ; exit 1 ; fi

  echo "$api_key" | run-in-docker ./scripts/login.sh
}

curl -sL https://github.com/huseyinbabal/taws/releases/latest/download/taws-x86_64-unknown-linux-gnu.tar.gz | tar xz
sudo mv taws /usr/local/bin/

taws

exit 0
