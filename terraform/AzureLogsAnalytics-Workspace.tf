# this Terraform File will create :
# - an Azure Resource Group
# - an Azure Logs Analytics Workspace (cf. https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-overview)
# - Output all usefull informations including Azure Logs Analytics Portal URL

# Resource Groupe Azure
resource "azurerm_resource_group" "Terra-RG-LogsAnalytics" {
  name     = "${var.RessourceGroup}"
  location = "${var.AzureRegion}"
}

 # more information : https://www.terraform.io/docs/providers/azurerm/r/log_analytics_workspace.html
resource "azurerm_log_analytics_workspace" "Terra-OMSWorkspace-ProjetP" {
  name                = "${var.OMSworkspace}"
  location            = "${azurerm_resource_group.Terra-RG-LogsAnalytics.location}"
  resource_group_name = "${azurerm_resource_group.Terra-RG-LogsAnalytics.name}"
  # Possible values : PerNode, Standard, Standalone
  # Standalone = Pricing per Gb, PerNode = OMS licence 
  # More info : https://azure.microsoft.com/en-us/pricing/details/log-analytics/
  sku                 = "Standard"
  # Possible values : 30 to 730
  retention_in_days   = 30
}

# Output post deployment
output "Workspace ID " {
    value="${azurerm_log_analytics_workspace.Terra-OMSWorkspace-Stan1.id}"
}

output "Workspace Customer ID" {
    value="${azurerm_log_analytics_workspace.Terra-OMSWorkspace-Stan1.workspace_id}"
}

output "Workspace primary Shared Key " {
    value="${azurerm_log_analytics_workspace.Terra-OMSWorkspace-Stan1.primary_shared_key}"
}

output "Workspace Secondary Shared Key " {
    value="${azurerm_log_analytics_workspace.Terra-OMSWorkspace-Stan1.secondary_shared_key}"
}

output "Portal URL " {
    value="${azurerm_log_analytics_workspace.Terra-OMSWorkspace-Stan1.portal_url}"
}