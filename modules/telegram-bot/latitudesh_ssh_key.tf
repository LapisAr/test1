resource "latitudesh_ssh_key" "ssh_key" {
  project    = latitudesh_project.project.id
  name       = var.ssh_key_owner
  public_key = var.ssh_public_key
}
