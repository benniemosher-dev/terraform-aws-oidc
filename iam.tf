locals {
  iam-role-name = var.config.iam-role-name != null ? var.config.iam-role-name : var.config.name
}

resource "aws_iam_role" "this" {
  assume_role_policy    = data.aws_iam_policy_document.assume-role.json
  description           = "Role used for ${local.iam-role-name}"
  force_detach_policies = var.config.force-detach-policies
  max_session_duration  = var.config.max-session-duration
  name                  = local.iam-role-name
  path                  = var.config.iam-role-path

  tags = {
    "Name" = local.iam-role-name
  }
}

resource "aws_iam_role_policy_attachment" "administrator-access" {
  count = var.config.attach-admin-policy ? 1 : 0

  policy_arn = "arn:${local.partition}:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.this.id
}

resource "aws_iam_role_policy_attachment" "read-only" {
  count = var.config.attach-read-only-policy ? 1 : 0

  policy_arn = "arn:${local.partition}:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.this.id
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = length(var.config.iam-role-policy-arns)

  policy_arn = var.config.iam-role-policy-arns[count.index]
  role       = aws_iam_role.this.id
}

resource "aws_iam_openid_connect_provider" "oidc-provider" {
  count = var.config.create-oidc-provider ? 1 : 0

  client_id_list = concat(
    ["sts.amazonaws.com"],
    var.config.oidc-provider-client-list
  )

  thumbprint_list = var.config.oidc-provider-thumbprint-list
  url             = var.config.oidc-provider-url

  tags = {
    "Name" = var.config.name
  }
}
