include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}
terraform {
  source = "tfr:///terraform-aws-modules/ecr/aws?version=2.3.0"
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
  }
}



inputs = {
  repository_name = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = merge(
    {
      name = replace("${basename(get_terragrunt_dir())}", "env", "${include.root.locals.env}")
    },
    include.root.locals.base_tags,
  )

}
