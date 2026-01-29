terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}
resource "aws_instance" "instance" {
  ami = data.aws_ami.ami.id
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  instance_type = var.instance_type
  tags = {
    Name = "${var.component}-${var.env}"
  }
}

# resource "aws_route53_record" "record" {
#   name    = ""
#   type    = ""
#   zone_id = ""
# }
# resource "null_resource" "ansible" {
#   provisioner "remote-exec" {
#
#   }
# }