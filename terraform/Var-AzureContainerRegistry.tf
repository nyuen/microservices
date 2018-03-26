# Variables (ici pour séparer le code de la config)

# Variable pour definir la region Azure ou deployer la plateforme
# Pour obtenir la liste des valeurs possible via la ligne de commande Azure, executer la commande suivante :
# az account list-locations
variable "AzureRegion" {
  type    = "string"
  default = "westeurope"
}

# Variable pour definir le nom du groupe de ressource ou deployer la plateforme
variable "RessourceGroup" {
  type    = "string"
  default = "RG-Stan1"
}

# Variable nom de l'Azure Container Registry
# Variable Azure Container Registry Name
variable "ACR-Name" {
  type    = "string"
  default = "acrstan1"
}

# Variable SKU de l'Azure Container Registry
# Variable Azure Container Registry Name
# Possible values : Classic, Basic, Standard, Premium
variable "ACR-SKU" {
  type    = "string"
  default = "Premium"
}
