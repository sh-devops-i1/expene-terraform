provider "vault" {
  address = "https://vault.mohdshuja.com:8200/"
  token   = var.vault_token
  skip_tls_verify = true
}

