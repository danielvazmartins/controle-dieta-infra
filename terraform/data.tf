data "aws_iam_policy_document" "controle_dieta_policy" {
  statement {
    sid      = "AllowPublicStaticWebSite"
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.controle_dieta.arn}/*"]
  }
}