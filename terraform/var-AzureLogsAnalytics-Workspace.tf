# Variables (ici pour séparer le code de la config)

# Variable pour definir la region Azure ou deployer la plateforme
variable "AzureRegion" {
  type    = "string"
  default = "westeurope"
}

# Variable pour definir le nom du groupe de ressource ou deployer la plateforme
variable "RessourceGroup" {
  type    = "string"
  default = "RG-ProjectP"
}

# Variable pour definir le nom du workspaceOMS (Azure Logs Analytics)
variable "OMSworkspace" {
  type    = "string"
  default = "OMSWorkspace-ProjetP"
}
