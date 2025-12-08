locals {
  tags = merge(
    {
      Project    = var.identifier
      ManagedBy  = "terraform"
      CostCenter = var.cost_center
    },
    var.extra_tags,
  )

  cloud_init_base64 = base64encode(templatefile("${path.module}/assets/cloud-init.sh.tmpl", {
    index_html = file("${path.module}/assets/index.html")
  }))
}

resource "azurerm_resource_group" "this" {
  name     = "${var.identifier}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.identifier}-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.allowed_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.allowed_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_cidr
    destination_address_prefix = "*"
  }

  tags = merge(local.tags, {
    Name = "${var.identifier}-nsg"
  })
}

resource "azurerm_public_ip" "this" {
  name                = "${var.identifier}-pip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(local.tags, {
    Name = "${var.identifier}-pip"
  })
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.identifier}-vnet"
  address_space       = [var.vnet_address_prefix]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = merge(local.tags, {
    Name = "${var.identifier}-vnet"
  })
}

resource "azurerm_subnet" "this" {
  name                 = "${var.identifier}-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_interface" "this" {
  name                = "${var.identifier}-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = merge(local.tags, {
    Name = "${var.identifier}-nic"
  })
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "${var.identifier}-vm"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = local.cloud_init_base64

  tags = merge(local.tags, {
    Name = "${var.identifier}-vm"
  })
}
