


module "tvnet" {
  source   = "git@github.com:ancoleman/terraform-azure-tfc-demo.git"
  location = local.region
  networks = local.networks[local.environment][local.region]
  rgs      = local.rgs[local.environment][local.region]
  sgs      = local.sgs[local.environment][local.region]
  peerings = local.peerings[local.environment][local.region]
  lbs      = local.lbs[local.environment][local.region]
  pips     = local.pips[local.environment][local.region]
}


//locals {
//  lb_rules = { for k,v  in local.lbs[local.environment][local.region] :
//  for i in v.rules:
//  i.frontend_ip_configuration_name => i}
//}
//
//output "rules" {
//  value = local.lb_rules
//}