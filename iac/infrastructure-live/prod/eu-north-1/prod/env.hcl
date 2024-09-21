# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  environment                = "prod"
  team                       = "DevOps"
  project                    = "project-name"
  cidr                       = "10.9.0.0/16"
  bastion_host_instance_type = "t3.nano"


}
