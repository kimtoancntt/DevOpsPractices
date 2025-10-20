resource "random_string" "acr_suffix" {
  length  = 6
  upper   = false
  special = false
}

module "resource_group" {
  source = "./modules/resource_groups"
  name = var.resource_group_name
  location = var.location
  tags = var.tags
}

module "container_registry" {
  source = "./modules/container_registry"
  name = "${var.container_registry_name}${random_string.acr_suffix.result}"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  sku = var.container_registry_sku
  tags = var.tags

  depends_on = [ module.resource_group ]
}


module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix

  depends_on = [ module.resource_group ]
}

module "kubernetes_service" {
  source              = "./modules/kubernetes_service"
  resource_group_name = "${module.resource_group.name}"
  location            = var.location
  cluster_name        = "${var.cluster_name}${random_string.acr_suffix.result}"
  dns_prefix          = var.dns_prefix
  node_pool_name      = var.node_pool_name
  node_count          = var.node_count
  vm_size             = var.vm_size
  subnet_id           = module.network.subnet_id
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  depends_on = [ module.network, module.resource_group ]
}