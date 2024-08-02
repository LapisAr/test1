output "server-ip" {
  value = latitudesh_server.telegram-bots-server.primary_ipv4
}

output "ssh_key" {
  value = latitudesh_ssh_key.ssh_key.public_key
}
