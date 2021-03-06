provider "aws" {
  region = "eu-west-1"
}

module "admin" {
  source = "../../modules/user"

  name    = "first.last.admin"
  path    = "/admins/"
  keybase = "itsdalmo"
}

module "developer" {
  source = "../../modules/user"

  name    = "first.last.developer"
  path    = "/developer/"
  keybase = "itsdalmo"
}

module "user_roles" {
  source          = "../../modules/user-roles"
  trusted_account = "<user-account>"

  admin_users = [
    "first.last.admin",
  ]

  view_only_users = [
    "first.last.developer",
  ]
}

module "machine_role" {
  source = "../../modules/machine-role"
  name   = "machine-user-role"

  trusted_principals = [
    "<lambda-function-arn>",
  ]
}
