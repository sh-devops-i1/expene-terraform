data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Redhat-9-DevOps-Practice"
  owners           = ["973714476881"]

}

data "vault_generic_secret" "mypass"{
   path = "common/common"
 }
#
