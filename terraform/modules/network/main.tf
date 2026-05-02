resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.project}-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.project}-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"

  source_address_prefix      = "*"
  destination_address_prefix = "*"
  }

security_rule {
  name                       = "allow-http"
  priority                   = 1002
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"

  source_port_range          = "*"
  destination_port_range     = "80"

  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}