# live/dev/terragrunt.hcl

terraform {
  source = "../../modules/telegram-bot"
}

inputs = {
  latitudesh_token   = "input your api key"
  hostname           = "Tu minh test"
  plan               = "c2.small.x86"
  region             = "TYO2"
  ssh_public_key     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEUo/uvNwhAI0BiUIbIih4m4eJ3t7zOnIXKFE3mnxMEr your_email@example.com"
  environment        = "Development"
  operating_system   = "ubuntu_22_04_x64_lts"
  ssh_key_owner      = "Happy"
}
