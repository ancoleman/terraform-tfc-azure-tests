locals {
  region = "centralus"
  environment = "default"
  rgs = {
    default = {
      centralus = {
        regionaltrainingtest = {}
      }
    }
  }

  networks = {
    default = {
      centralus = {
        trainingtvnet1 = {
          resource_group_name = "regionaltrainingtest"
          address_space = [
          "10.200.0.0/24"]
          subnets = {
            management = "10.200.0.0/28"
            untrust    = "10.200.0.16/28"
            trust      = "10.200.0.32/28"
          }
        }
        trainingsvnet1 = {
          resource_group_name = "regionaltrainingtest"
          address_space = [
          "10.220.0.0/24"]
          subnets = {
            test1 = "10.220.0.32/28"
          }
        }
        trainingsvnet2 = {
          resource_group_name = "regionaltrainingtest"
          address_space = [
          "10.221.0.0/24"]
          subnets = {
            test1 = "10.221.0.32/28"
          }
        }
      }
    }
  }


  sgs = {
    default = {
      centralus = {
        mgmt = {
          resource_group_name = "regionaltrainingtest"
          rules = {
            allow_ssh = {
              priority                   = 100
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "Tcp"
              source_port_range          = "22"
              destination_port_range     = "22"
              source_address_prefix      = "69.148.174.55/32"
              destination_address_prefix = "10.200.0.0/28"
            }
            allow_https = {
              priority                   = 101
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "Tcp"
              source_port_range          = "443"
              destination_port_range     = "443"
              source_address_prefix      = "69.148.174.55/32"
              destination_address_prefix = "10.200.0.0/28"
            }
          }
        }
        untrust = {
          resource_group_name = "regionaltrainingtest"
          rules = {
            allow_internet = {
              priority                   = 100
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "*"
              source_port_range          = "*"
              destination_port_range     = "*"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            }
          }
        }
        trust = {
          resource_group_name = "regionaltrainingtest"
          rules = {
            allow_internal = {
              priority                   = 100
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "*"
              source_port_range          = "*"
              destination_port_range     = "*"
              source_address_prefix      = "10.0.0.0/8"
              destination_address_prefix = "*"
            }
          }
        }
      }
    }
  }

  peerings = {
    default = {
      centralus = {
        peering-to-spoke1 = {
          remote_vnet_name             = "trainingsvnet1"
          resource_group_name          = "regionaltrainingtest"
          vnet_name                    = "trainingtvnet1"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = null
          use_remote_gateways          = null
        }
        peering-to-spoke2 = {
          remote_vnet_name             = "trainingsvnet2"
          resource_group_name          = "regionaltrainingtest"
          vnet_name                    = "trainingtvnet1"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = null
          use_remote_gateways          = null
        }
        spoke1-to-tvnet = {
          remote_vnet_name             = "trainingtvnet1"
          resource_group_name          = "regionaltrainingtest"
          vnet_name                    = "trainingsvnet1"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = null
          use_remote_gateways          = null
        }
        spoke2-to-tvnet = {
          remote_vnet_name             = "trainingtvnet1"
          resource_group_name          = "regionaltrainingtest"
          vnet_name                    = "trainingsvnet2"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = null
          use_remote_gateways          = null
        }
      }
    }
  }
  pips = {
    default = {
      centralus = {
        public-slb-tvnet1-pip1 = {
          resource_group_name = "regionaltrainingtest"
          allocation_method   = "Static"
        }
        public-slb-tvnet1-pip2 = {
          resource_group_name = "regionaltrainingtest"
          allocation_method   = "Static"
        }
        public-slb-tvnet1-pip3 = {
          resource_group_name = "regionaltrainingtest"
          allocation_method   = "Static"
        }
      }
    }
  }

  lbs = {
    default = {
      centralus = {
        public-slb-tvnet1 = {
          resource_group_name = "regionaltrainingtest"
          probe = {
            name     = "firewall-22-check"
            port     = 22
            protocol = "tcp"
          }
          rules = [
            {
              backend_port                   = "443"
              resource_group_name            = "regionaltrainingtest"
              frontend_ip_configuration_name = "public-slb-tvnet1-pip1"
              frontend_port                  = "443"
              protocol                       = "tcp"
            },
            {
              backend_port                   = "443"
              resource_group_name            = "regionaltrainingtest"
              frontend_ip_configuration_name = "public-slb-tvnet1-pip2"
              frontend_port                  = "443"
              protocol                       = "tcp"
            }
          ]
          public = {
            public-slb-tvnet1-pip1 = {
              subnet_id                     = null
              private_ip_address            = null
              private_ip_address_allocation = null
              public_ip_address_name        = "public-slb-tvnet1-pip1"
              public_ip_prefix_name         = null
              zones                         = null
            }
            public-slb-tvnet1-pip2 = {
              subnet_id                     = null
              private_ip_address            = null
              private_ip_address_allocation = null
              public_ip_address_name        = "public-slb-tvnet1-pip2"
              public_ip_prefix_name         = null
              zones                         = null
            }
            public-slb-tvnet1-pip3 = {
              subnet_id                     = null
              private_ip_address            = null
              private_ip_address_allocation = null
              public_ip_address_name        = "public-slb-tvnet1-pip3"
              public_ip_prefix_name         = null
              zones                         = null
            }
          }
          private = {}
        }
      }
    }
  }
}