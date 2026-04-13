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

resource "aws_security_group" "main-sg" {
  name               = "${var.component}-${var.env}-sg"
  vpc_id             = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

resource "aws_instance" "instance" {
  ami                     = data.aws_ami.ami.id
  vpc_security_group_ids  = [aws_security_group.main-sg.id]
  instance_type           = var.instance_type
  subnet_id               = var.subnet[0]
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
  connection {
    type        = "ssh"
    host        = aws_instance.instance.private_ip
    user        = jsondecode(data.vault_generic_secret.mypass.data_json).ansible_user
    password    = jsondecode(data.vault_generic_secret.mypass.data_json).ansible_password
  }
  provisioner "remote-exec" {
    inline = [
      "rm -f ~/secrets.json ~/app.json",
     "sudo pip3.11 install ansible hvac",
      "ansible-pull -i localhost, -U https://github.com/sh-devops-i1/expense-ansible.git -e env=${var.env} -e role_name=${var.component} get-secrets.yml -e  vault_token=${var.vault_token}",
      "ansible-pull -i localhost, -U https://github.com/sh-devops-i1/expense-ansible.git -e env=${var.env} -e role_name=${var.component} expense.yml -e @secrets.json -e @app.json"
    ]

  }

  provisioner "remote-exec" {
    inline = [
      "rm -f ~/secrets.json ~/app.json"
    ]
  }
}


resource "aws_lb" "main" {
  count              = var.lb_needed ? 1 : 0
  name               = "${var.env}-${var.component}-alb"
  internal           = var.lb_type == "public" ? true : false
  load_balancer_type = "application"
  security_groups = [aws_security_group.main-sg.id]
  subnets            = var.lb_subnet

  tags = {
    Environment = "${var.env}-${var.component}-alb"
  }
}

resource "aws_lb_target_group" "main"{
  count              = var.lb_needed ? 1 : 0
  name        = "${var.env}-${var.component}-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "main" {
  count            = var.lb_needed ? 1 : 0
  target_group_arn = aws_lb_target_group.main[0].arn
  target_id        = aws_instance.instance.id
  port             = var.app_port
}

resource "aws_lb_listener" "front_end" {
  count             = var.lb_needed ? 1 : 0
  load_balancer_arn = aws_lb.main[0].arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[0].arn
  }

}