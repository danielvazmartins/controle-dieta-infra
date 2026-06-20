variable "bucket_name" {
  description = "Nome do bucket S3 para hospedar a SPA"
  type        = string
}

variable "domain_name_app" {
  description = "Domínio para o certificado ACM da aplicação"
  type        = string
}

variable "domain_name_api" {
  description = "Domínio para o certificado ACM da API"
  type        = string
}
