module "frontend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "frontend"
  zone_id = var.zone_id
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
}