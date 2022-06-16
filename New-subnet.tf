
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
  subscription_id = "12cd5e08-b3ef-4053-ba46-53858664da44"
  skip_provider_registration = "ture"
}

resource "azurerm_resource_group" "example" {
  name     = "RGP-VA-NETWORK-IVR-AZ-STAGE"
  location = West US
  tags     = Test
}
resource "azurerm_virtual_network" "virtual_network1" {
  name = "Test-Virtual-Network-1"
  address_space = "10.10.10.0/24"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "subnet-1" {
  name = "Test-subnet1"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.virtual_network1.name
  address_prefix = ["10.10.10.0/28"]
}

resource "azurerm_NSG" "NSG-1" {
  name = "Network-Security-Group-1"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id = azurerm_subnet.subnet-1.id
  security_rule {
    name = "rule1"
    priority = "200"
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "10.10.10.0/28"
  }  
  tags {
    environment = "Testing"
    }
}

resource "azurerm_route_table" "RT1" {
  name = "Test-Route-Table-1"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id = azurerm_subnet.subnet-1.id
  route1 {
    name = "Outbound-route-1"
    address_prefix = ""
    next_hop_type = ""
    next_hop_in_ip_address = ""
  }
  tags {
    environment = "Testing"
  }
}
