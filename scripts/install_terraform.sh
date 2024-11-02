#!/bin/bash
set -x

if [ -z "$1" ]; then
  echo "Set terraform version. For example: ./install_terraform.sh 1.2.3"
  exit 1
fi

TERRAFORM_VERSION="$1"
TERRAFORM_URL="https://hashicorp-releases.yandexcloud.net/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
#TERRAFORM_URL="https://hashicorp-releases.yandexcloud.net/terraform/1.4.0/terraform_1.4.0_linux_amd64.zip"
#TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
INSTALL_DIR="/usr/local/bin"


curl -sLo terraform.zip $TERRAFORM_URL
unzip -oq terraform.zip
sudo mv -f terraform $INSTALL_DIR/
rm terraform.zip
terraform -uninstall-autocomplete
terraform -install-autocomplete
set +x
