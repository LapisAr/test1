resource "latitudesh_user_data" "user_data" {
    project = latitudesh_project.project.id
    description = "Initial server"
    content = filebase64("${path.module}/user_data/user_data.sh")
}