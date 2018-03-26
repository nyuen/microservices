# Azure ressource group
# Resource Groupe Azure
resource "azurerm_resource_group" "Terra-RG-Stan1" {
  name     = "${var.RessourceGroup}"
  location = "${var.AzureRegion}"
}

# Cluster AKS
# AKS Cluster
resource "azurerm_kubernetes_cluster" "Terra-AKS-Stan1" {
  name                   = "${var.AKS-Name}"
  location               = "${var.AzureRegion}"
  resource_group_name    = "${var.RessourceGroup}"
  kubernetes_version     = "${var.KubernetesVersion}"
  dns_prefix             = "${var.DNSPrefix}"
  
  linux_profile {
    admin_username = "${var.AdminName}"

    ssh_key {
      key_data = "${var.SSHKeyAdmin}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_A1"
    os_type         = "Linux"
  }

  service_principal {
    client_id     = "${var.SPNClientID}"
    client_secret = "${var.SPNClientSecret}"
  }

  tags {
    Environment = "Production"
  }
}
