resource "aws_s3_bucket" "controle_dieta" {
  bucket = "controle-dieta-spa-angular"
}

resource "aws_s3_bucket_website_configuration" "controle_dieta_website" {
  bucket = aws_s3_bucket.controle_dieta.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "controle_dieta_public_access" {
  bucket = aws_s3_bucket.controle_dieta.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "controle_dieta_policy" {
  bucket = aws_s3_bucket.controle_dieta.id

  policy = data.aws_iam_policy_document.controle_dieta_policy.json  
}