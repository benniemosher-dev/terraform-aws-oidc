locals {
  partition     = data.aws_partition.current.partition
  oidc-provider = var.config.create-oidc-provider ? aws_iam_openid_connect_provider.oidc-provider[0] : data.aws_iam_openid_connect_provider.oidc-provider[0]
}
