include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}
terraform {
  source = "tfr:///terraform-aws-modules/secrets-manager/aws//?version=1.1.2"
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
  }
}

inputs = {
  name                   = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
  description            = "GitLab personal access token for the pipeline"
  environment            = ""
  create_random_password = false
  ignore_secret_changes  = true

  secret_string = get_env("project-name_GITHUB_ACCESS_TOKEN")

  tags = merge(
    include.root.locals.base_tags,
  )

}
