# ─────────────────────────────────────────────────────────────
# Dockerfile — Terraform runner for Terraformkm
# Packages: Terraform >= 1.0, AWS CLI v2
# ─────────────────────────────────────────────────────────────
FROM hashicorp/terraform:1.8.5

# Install utilities + AWS CLI v2 via official binary (avoids pip/pyexpat conflicts on Alpine)
RUN apk add --no-cache \
    curl \
    unzip \
    bash \
    git \
    jq \
    gcompat \
    libstdc++ \
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws \
    && terraform --version \
    && aws --version

# Set working directory
WORKDIR /workspace

# Copy Terraform configuration files
COPY main.tf .
COPY variables.tf .
COPY terraform.tfvars .

# Terraform state / credentials are injected at runtime via env vars;
# never bake secrets into the image.

# Default entrypoint — override in Jenkins with specific terraform commands
ENTRYPOINT ["terraform"]
CMD ["--help"]
