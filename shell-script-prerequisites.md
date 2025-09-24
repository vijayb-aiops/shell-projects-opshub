# 🚀 AWS EC2 Free Tier Setup Guide (All Steps in One Place)

## Step 1: Install AWS CLI
Follow AWS official docs: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

Verify installation:
aws --version

Expected output:
aws-cli/2.15.X Python/3.X.X Windows/10 exe/AMD64

---

## Step 2: Create an IAM User with CLI Credentials
1. Log into AWS Console as Root user
2. Navigate to: IAM → Users → Add users
3. Enter a username (example: devops-admin)
4. Leave the “Provide user access to the AWS Management Console” unchecked 
   (you don’t need console login) and Click Next..
4. On Permissions step → Attach policies directly → select AdministratorAccess
5. Finish creating the user
6. Go to the user’s Security credentials tab
7. Under Access keys → Create access key
8. Choose “Command Line Interface (CLI)” as the use case
9. Copy Access Key ID and Secret Access Key (download the .csv file)

---

## Step 3: Configure AWS CLI
Run:
aws configure

Fill in:
AWS Access Key ID [None]: <Paste your Access Key ID>
AWS Secret Access Key [None]: <Paste your Secret Access Key>
Default region name [None]: us-east-1
Default output format [None]: json

This saves credentials into: ~/.aws/credentials

---

## Step 4: Verify Authentication
Run:
aws sts get-caller-identity

Expected output:
{
    "UserId": "AIDAEXAMPLE12345",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/devops-admin"
}

✅ If you see your account number and IAM username, authentication is successful.
