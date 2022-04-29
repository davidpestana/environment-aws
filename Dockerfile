FROM amazon/aws-cli
ENV HOME /root
# INSTALL WGET AND UTILS
RUN yum install -y wget openssl jq tar gzip
RUN yum install -y yum-utils


# INSTALL KUBECTL
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl && \
    curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl.sha256 && \
    openssl sha1 -sha256 kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN kubectl version --short --client

# INSTALL HELM
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN sh get_helm.sh


# INSTALL KOPS
# RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 
# RUN chmod +x kops && mv kops /usr/local/bin/kops


# INSTALL GIT
RUN yum -y install git

# INSTALL TERRAFORM
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
RUN yum -y install terraform-0.14.5-1

#INSTALL TERRAFORM-DOCS
RUN curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz \
&& tar -xzf terraform-docs.tar.gz \
&& chmod +x terraform-docs \
&& mv terraform-docs /usr/local/bin/terraform-docs

# INSTALL TERRAGRUNT
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.32.5/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt