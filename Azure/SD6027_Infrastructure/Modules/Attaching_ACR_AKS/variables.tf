variable "aks_identity_id" {
    type = string
    description = "The ID of the AKS cluster's managed identity."

}

variable "acr_scope" {
    type = string
    description = "The scope of the ACR role assignment."
}