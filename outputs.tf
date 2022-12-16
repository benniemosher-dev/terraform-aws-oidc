output "iam-role-name" {
  description = "Name of the IAM role."
  value       = aws_iam_role.this.name
}
