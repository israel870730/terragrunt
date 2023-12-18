terraform {
  source = "../../../../../Terraform-Modules/network/vpc/"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path              = find_in_parent_folders("/common/env.hcl")
  expose            = true
  merge_strategy    = "no_merge"
}

inputs = merge(
  yamldecode(file("${find_in_parent_folders("/common/inputs-dev.yaml")}")),
  #yamldecode(file("${find_in_parent_folders("/common/secrets.yaml")}"))
)