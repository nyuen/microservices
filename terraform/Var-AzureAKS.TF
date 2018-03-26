# Variables (ici pour séparer le code de la config)

# Variable pour definir la region Azure ou deployer la plateforme
# Pour obtenir la liste des valeurs possible via la ligne de commande Azure, executer la commande suivante :
# az account list-locations
variable "AzureRegion" {
  type    = "string"
  default = "westeurope"
}

# Variable pour definir le nom du groupe de ressource ou deployer la plateforme
# Variable Resource Group Name
variable "RessourceGroup" {
  type    = "string"
  default = "RG-Stan1-AKS1"
}

# Variable nom du cluster AKS
# Variable AKS Name
variable "AKS-Name" {
  type    = "string"
  default = "aks-stan1"
}

# Variable nombre de nodes Kubernetes
# Variable number of kubernetes nodes
# Min : 3, Recommended : 3 or more
variable "Nb-NodesKubernetes" {
  type    = "string"
  default = "3"
}

# Kubernetes Version
variable "KubernetesVersion" {
  type    = "string"
  default = "1.8.1"
}

# Variable DNS Préfixe
# Variable DNS Prefix
variable "DNSPrefix" {
  type    = "string"
  default = "stan2018"
}

# Variable admin name
# Variable nom d'admin
variable "AdminName" {
  type    = "string"
  default = "stan"
}

# Variable clé publique SSH
# SSH public key
variable "SSHKeyAdmin" {
  type    = "string"
  default = "ssh-rsa insérer la clé SSH publique"
}

# Variable Service Principal clientID
variable "SPNClientID" {
  type    = "string"
  default = "insérer clientID"
}

# Variable Service Principal clientSecret
variable "SPNClientSecret" {
  type    = "string"
  default = "insérer Client Secret"
}
