include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "../../../../../infrastructure-modules//datasources"
}

inputs = {
  acm_domain = "*.project-name.tech"
}