include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}
terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-group-with-policies?version=5.44.0"
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
  }
}

locals {
  group_name  = regex("[^.]+$", "${basename(get_terragrunt_dir())}")
  user_folder = "${get_terragrunt_dir()}/../../iam-users/${local.group_name}"
  fetch_users = run_cmd("${get_parent_terragrunt_dir()}/scripts/list_users.sh", "${local.user_folder}")
  users       = split("\n", trimspace(local.fetch_users))
}

inputs = {
  name                              = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
  description                       = "Allow DevOps to perform administrative operations."
  group_users                       = local.users
  attach_iam_self_management_policy = true
  policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]

  tags = merge(
    {
      name = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
    },
    include.root.locals.base_tags,
  )
}
