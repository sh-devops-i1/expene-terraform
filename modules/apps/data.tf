data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Redhat-9-DevOps-Practice"
  owners           = ["973714476881"]

}
data "aws_security_group" "selected" {
  name = "allow-all"
}
data "vault_generic_secret" "mypass"{
  path = "expense-dev/test"
}
resource "local_file" "foo" {
  content  = data.vault_generic_secret.mypass.data_json
  filename = "/tmp/secrets"
}
