
# Azure ressource group
# Resource Groupe Azure
resource "azurerm_resource_group" "Terra-RG-Stan1" {
  name     = "${var.RessourceGroup}"
  location = "${var.AzureRegion}"
}

# Azure Container Registry
resource "azurerm_container_registry" "Terra-ACR-Stan1" {
  name                = "${var.ACR-Name}"
  resource_group_name = "${azurerm_resource_group.Terra-RG-Stan1.name}"
  location            = "${azurerm_resource_group.Terra-RG-Stan1.location}"
  admin_enabled       = true
  sku                 = "${var.ACR-SKU}"
}