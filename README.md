# Deploying Infrastructure and Applications on AWS using Terragrunt

## **Overview**
This guide will walk you through deploying infrastructure and running a sample app on AWS using Terraform modules with Terragrunt. The deployment will be managed on AWS EKS with Helm, ArgoCD, and secure management of Helm secrets using AWS KMS.

The project handles core AWS infrastructure needs such as VPC, EC2 bastion host, IAM roles, EKS, and RDS, and provides a robust CI/CD pipeline for app deployment with ArgoCD.

## **Prerequisites**

Ensure the following tools are installed on your local machine:
1. **Terragrunt**: For managing Terraform modules.
2. **AWS CLI**: For interacting with AWS services.
3. **kubectl**: To manage your Kubernetes cluster.
4. **Helm**: For deploying applications on Kubernetes.
5. **ArgoCD CLI**: To manage your CI/CD pipelines.
6. **Terraform**: Ensure it is installed if not working solely through Terragrunt.

## **Setup AWS Credentials**

Set up your AWS CLI with the necessary credentials:

```bash
aws configure
```
Provide your AWS access key, secret access key, default region, and output format.

## Step-by-Step Guide

First, clone the project repository to your local machine:


```bash
git clone git@github.com:umairedu/terragrunt_baseline_aws_k8s.git
cd terragrunt_baseline_aws_k8s/iac/infrastructure-live/prod/eu-north-1/prod/
```
## Deploy AWS Infrastructure

Use Terragrunt to deploy the required AWS infrastructure. Ensure that all modules such as VPC, IAM, Security Groups, EC2 bastion host, and EKS cluster are configured properly.

Run the following commands:

```bash
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
```
This will provision your VPC, IAM roles, security groups, RDS, and other required resources.

## Set Up EKS Cluste
Once the infrastructure is deployed, configure your `kubectl` to interact with your new EKS cluster:

```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
```
This command will authenticate kubectl with your EKS cluster.

## Deploy Applications on EKS
Deploy applications using the Helm chart on your Kubernetes cluster. This project comes with a generic Helm chart that can be used for all types of app deployments.

To deploy an application, run:
```bash
cd kubernetes/charts/
helm install generic-chart -f generic-chart/core/production/values.yaml
```