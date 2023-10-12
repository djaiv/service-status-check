# Apache Service Status Check

This IaC Code performs a status check on Apache service every one minute

# AWS Services used

* AWS Systems Manager (RunCommand)
* AWS Eventbridge (previously Cloudwatch Event)
* AWS Simple Notification Service

## Assumptions
* You have a provisioned EC2 Instance and it is running
* Your Instance have an IAM role attached to it 
* The IAM Role attached to to your instance has the following permissions:
        [AmazonSNSFullAccess](https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonSNSFullAccess)
        [AmazonSSMManagedInstanceCore](https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonSSMManagedInstanceCore)

# usage

```
# Dry-run
terraform init
terraform plan -var-file=dev.tfvars

# apply the change(s)
terraform apply -var-file=dev.tfvars
```