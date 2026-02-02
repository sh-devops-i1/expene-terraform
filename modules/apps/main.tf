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
    monitor = "yes"
    env     = var.env
  }
}

resource "aws_route53_record" "record" {
  name    = "${var.component}-${var.env}"
  type    = "A"
  zone_id = var.zone_id
  records = [aws_instance.instance.private_ip]
  ttl     = 30
}
resource "null_resource" "ansible" {
  provisioner "remote-exec" {
    inline = [
     "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/sh-devops-i1/expense-ansible.git -e env=${var.env} -e role_name=${var.component} expense.yml "
    ]
    connection {
      type        = "ssh"
      host        = aws_instance.instance.public_ip
      user        = var.ssh_user
      password    = var.ssh_password
    }

  }
}