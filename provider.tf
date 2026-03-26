provider "vault" {
  address = "https://54.210.226.72:8200/"
  token   = var.vault_token
  skip_tls_verify = true
}

