# ─────────────────────────────────────────────────────────────
# Dockerfile — Terraform + AWS CLI runner for Terraformkm
# Base: Debian slim (glibc) — avoids musl/Alpine compatibility
#       issues with the AWS CLI v2 binary
# ─────────────────────────────────────────────────────────────
FROM debian:bookworm-slim

ARG TERRAFORM_VERSION=1.8.5

# Install system dependencies + AWS CLI v2
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    git \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    \
    # Install Terraform binary
    && curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
       -o /tmp/terraform.zip \
    && unzip -q /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip \
    \
    # Install AWS CLI v2 binary
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
       -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws \
    \
    # Smoke test
    && terraform --version \
    && aws --version

WORKDIR /workspace

COPY main.tf .
COPY variables.tf .
COPY terraform.tfvars .

# Credentials injected at runtime via env vars — never baked in
ENTRYPOINT ["terraform"]
CMD ["--help"]
