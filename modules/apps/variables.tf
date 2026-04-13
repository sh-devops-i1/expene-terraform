variable "env" {}
variable "instance_type" {}
variable "component" {}
variable "zone_id" {}
variable "vault_token" {}
variable "vpc_id" {}
variable "subnet" {}
variable "lb_type" {
  default = null
}
variable "lb_needed" {
  default = false
}
variable "lb_subnet" {
  default = null
}
variable "app_port" {
  default = null
}
