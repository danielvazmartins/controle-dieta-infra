variable "bucket_name" {
  description = "Nome do bucket S3 para hospedar a SPA"
  type        = string
}

variable "domain_name" {
  description = "Domínio para o certificado ACM"
  type        = string
}
