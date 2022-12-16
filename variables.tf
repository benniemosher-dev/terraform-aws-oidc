variable "config" {
  description = "The config for creating this module."
  type = object({
    attach-admin-policy           = optional(bool, false)
    attach-read-only-policy       = optional(bool, true)
    create-oidc-provider          = optional(bool, true)
    force-detach-policies         = optional(bool, false)
    github-repositories           = optional(list(string), [])
    github-organisation           = string
    oidc-provider-thumbprint-list = optional(list(string), [])
    oidc-provider-url             = optional(string, null)
    iam-role-name                 = optional(string, null)
    iam-role-path                 = optional(string, "/")
    iam-role-policy-arns          = optional(list(string), [])
    max-session-duration          = optional(number, 3600)
    oidc-provider-client-list     = optional(list(string), [])
    name                          = string
  })
}
