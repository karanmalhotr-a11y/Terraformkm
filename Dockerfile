# ─────────────────────────────────────────────────────────────
# Dockerfile — Terraform runner for Terraformkm
# Packages: Terraform >= 1.0, AWS CLI v2
# ─────────────────────────────────────────────────────────────
FROM hashicorp/terraform:1.8.5

# Install AWS CLI v2 and basic utilities
RUN apk add --no-cache \
    curl \
    unzip \
    bash \
    python3 \
    py3-pip \
    git \
    jq \
    && pip3 install --break-system-packages awscli \
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
