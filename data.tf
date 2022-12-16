data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringLike"
      values   = [for repo in var.config.github-repositories : "repo:${var.config.github-organisation}/${repo}:*"]
      variable = "token.actions.githubusercontent.com:sub"
    }

    principals {
      identifiers = [local.oidc-provider.arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_openid_connect_provider" "oidc-provider" {
  count = !var.config.create-oidc-provider ? 1 : 0

  url = var.config.oidc-provider-url
}
