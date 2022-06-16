
terraform {
  required_version = "> 0.13"
    required_provider {
      azurerm = {
        version = "~> 2.0"
      }
    }
}

provider "azurerm" {
  feature {}
  subscription_id = "a7a291cc-f966-4769-a33b-2fa46cedc33d"
  skip_provider_registration = "ture"
}

resource "azurerm_resource_group" "IVR-VA-STG" {
  name     = "RGP-VA-NETWORK-IVR-AZ-STAGE"
  location = var.location
  tags     = var.tags_customer
}

resource "azurerm_subnet" "subnet-AKS" {
  name = ""
  resource_group_name =
  virtual_network_name =
  address_prefix = ""
}

resource "azurerm_NSG" "NSG-IVR-AKS-VA" {
  name = "NSG-SUB-IVR-AKS-VA-STG"
  location = azurerm_resource_group.IVR-VA-STG.location
  resource_group_name = azurerm_resource_group.IVR-VA-STG.name
  subnet_id = azurerm_subnet.subnet-AKS.id
  security_rule {
    name = ""
    priority = ""
    direction = ""
    access = ""
    protocol = ""
    source_port_range = ""
    destination_port_range = ""
    source_address_prefix = ""
    destination_address_prefix = ""
  }  
  tags {
    LOB = "IVR"
    environment = "Staging"
    }
}

resource "azurerm_route_table" "Routa_table_IVR-AKS-VA" {
  name = "RT-SUB-IVR-AKS-VA-STG"
  location = azurerm_resource_group.IVR-VA-STG.location
  resource_group_name = azurerm_resource_group.IVR-VA-STG.name
  subnet_id = azurerm_subnet.subnet-AKS.id
  route1 {
    name = ""
    address_prefix = ""
    next_hop_type = ""
    next_hop_in_ip_address = ""
  }
  route2 {
    name = ""
    address_prefix = ""
    next_hop_type = ""
    next_hop_in_ip_address = ""
  }
  tags {
    LOB = "IVR"
    environment = "Staging"
  }
}
