terraform {
  source = "../../../../Terraform-Modules/network/vpc/"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = merge(
  yamldecode(file("${find_in_parent_folders("/common/inputs-staging.yaml")}")),
  yamldecode(file("${find_in_parent_folders("/common/secrets.yaml")}"))
)