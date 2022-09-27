# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
locals {
}

terraform {
  source = "github.com/colt-net/terraform-modules//stacks/policies?ref=v1.0.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "parent" {
  config_path = "../../sandbox/"
  mock_outputs = {
    folder_id = "sandbox"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  policy_for = "folder"
  folder_id  = dependency.parent.outputs.folder_id

  policy_require_oslogin      = false
  policy_svc_acc_key_creation = false

}
