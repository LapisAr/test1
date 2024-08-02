resource "latitudesh_project" "project" {
  name        = "Solana Ecosystem"
  description = "Ecosystem for telegram bots"
  environment = var.environment
  provisioning_type = "on_demand"
}
