include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}
terraform {
  source = "tfr:///terraform-aws-modules/key-pair/aws//.?version=2.0.3"
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
  }
}

inputs = {
  key_name   = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
  public_key = "your-key"

  tags = merge(
    {
      name = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
    },
    include.root.locals.base_tags,
  )

}
