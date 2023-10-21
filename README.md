## Introduction

The "AWS_IaC" project leverages Terraform to automate the creation of AWS resources. This README will guide you through the process of setting up and using these Terraform scripts to manage your infrastructure.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- **Terraform**: Install [Terraform](https://www.terraform.io/downloads.html) on your local machine.
- **AWS Account**: You should have an AWS account with appropriate credentials.
- **AWS CLI**: Configure your AWS credentials using the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) or using environment variables.
- **Familiarity with AWS and Terraform**: Understanding of AWS services and Terraform concepts is recommended.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
      git clone https://github.com/GiovaniDeJesus/AWS_IaC.git
   ```
2. Change your working directory to the cloned repository:
   ```bash
      cd AWS_IaC
   ```
3. Initialize the Terraform workspace:
   ```bash
      terraform init
   ```
4. Apply the Terraform configuration to create your AWS resources:
   ```bash
      terraform apply
   ```
