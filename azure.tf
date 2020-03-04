provider "azurerm" {}


locals {
  workspace_split_region = split("_", terraform.workspace)
  region                 = element(local.workspace_split_region, 1)
  workspace_split_environment = split("-", element(local.workspace_split_region, 0))
  environment                 = element(local.workspace_split_environment, 2)
}