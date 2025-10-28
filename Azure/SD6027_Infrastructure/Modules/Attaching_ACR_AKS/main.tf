resource "azurerm_role_assignment" "example" {
  principal_id                     = var.aks_identity_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_scope
  skip_service_principal_aad_check = true
}