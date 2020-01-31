FROM bdbstudios/alpine-base

ARG TERRAFORM_VERSION="0.12.6"
ARG TERRAFORM_BASE_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}"
ARG TERRAFORM_URL="${TERRAFORM_BASE_URL}_linux_amd64.zip"
ARG TERRAFORM_HASH_URL="${TERRAFORM_BASE_URL}_SHA256SUMS"
ARG TF_USER="terraform"
ARG TERRAGRUNT_VERSION='v0.17.0'
ARG TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/download/"

USER root

# Install terraform
RUN cd /tmp; \
    wget ${TERRAFORM_URL}; \
    wget ${TERRAFORM_HASH_URL}; \
    cat terraform_${TERRAFORM_VERSION}_SHA256SUMS | grep "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
        > terraform_${TERRAFORM_VERSION}.SHA256SUMS; \
    sha256sum -c terraform_${TERRAFORM_VERSION}.SHA256SUMS; \
    unzip terraform*.zip; \
    mv terraform /usr/bin/.; \
    chmod +x /usr/bin/terraform; \
    rm -rf /tmp/* /var/logs/*; \
    wget ${TERRAGRUNT_URL}${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
        -O /usr/bin/terragrunt; \
    chmod +x /usr/bin/terragrunt

COPY docker/tests /home/tools/tests

VOLUME ["/home/tools/data"]
USER tools
WORKDIR /home/tools/data
