resource "latitudesh_server" "server" {
  hostname         = var.hostname
  operating_system = var.operating_system
  plan             = data.latitudesh_plan.plan.slug
  project          = latitudesh_project.project.id      # You can use the project id or slug
  site             = data.latitudesh_region.region.slug # You can use the site id or slug
  ssh_keys         = [latitudesh_ssh_key.ssh_key.id]
}
