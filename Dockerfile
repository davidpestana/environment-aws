FROM amazon/aws-cli

RUN yum install -y yum-utils

# INSTALL TERRAFORM
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
RUN yum -y install terraform-0.14.5-1