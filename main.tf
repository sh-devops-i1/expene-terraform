module "frontend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "frontend"
}