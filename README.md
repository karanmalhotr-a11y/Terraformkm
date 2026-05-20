# Terraform AWS Project

This project creates AWS infrastructure including VPC, subnets, security groups, and EC2 instances.

## Prerequisites

- Terraform >= 1.0
- AWS CLI installed
- AWS credentials configured

## Setting Up AWS Credentials

### Option 1: Using AWS Credentials File (Recommended)

1. **Add your credentials to `~/.aws/credentials`:**
   ```
   [default]
   aws_access_key_id = YOUR_ACCESS_KEY_ID
   aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
   
   [production]
   aws_access_key_id = YOUR_PROD_ACCESS_KEY_ID
   aws_secret_access_key = YOUR_PROD_SECRET_ACCESS_KEY
   ```

2. **Add your regions to `~/.aws/config`:**
   ```
   [default]
   region = us-east-1
   
   [profile production]
   region = us-west-2
   ```

3. **Update `terraform.tfvars`** to specify which profile to use:
   ```hcl
   aws_profile = "default"  # or "production"
   ```

### Option 2: Using Environment Variables

Set environment variables before running Terraform:

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-east-1"
```

Then leave `aws_profile` as default in `terraform.tfvars`.

### Option 3: Using AWS IAM Role (For AWS EC2/Lambda/ECS)

If running from an AWS service, no credentials are needed - the IAM role will be used automatically.

## Usage

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Review planned changes:**
   ```bash
   terraform plan
   ```

3. **Apply configuration:**
   ```bash
   terraform apply
   ```

4. **Destroy resources:**
   ```bash
   terraform destroy
   ```

## Files

- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable definitions
- `terraform.tfvars` - Variable values
- `.gitignore` - Git ignore rules for Terraform

## Security Best Practices

✅ **DO:**
- Store credentials in `~/.aws/credentials`
- Use environment variables in CI/CD pipelines
- Use IAM roles on AWS services
- Keep `.gitignore` configured
- Use separate AWS profiles for different environments

❌ **DON'T:**
- Commit credentials to git
- Hardcode credentials in `.tf` files
- Share AWS credentials
- Store credentials in `.tfvars` files committed to git
- Use root AWS accounts for daily work

## Environment Variables Reference

- `AWS_PROFILE` - AWS CLI profile to use
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `AWS_DEFAULT_REGION` - Default AWS region

## Troubleshooting

If Terraform can't find credentials:
1. Verify credentials file exists: `~/.aws/credentials`
2. Check permissions: `chmod 600 ~/.aws/credentials`
3. Verify environment variables: `env | grep AWS`
4. Test AWS CLI: `aws s3 ls`
