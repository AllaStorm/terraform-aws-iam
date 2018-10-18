# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
data "aws_iam_account_alias" "current" {}

resource "aws_iam_role" "main" {
  name                  = "${var.name}"
  description           = "Machine user role"
  assume_role_policy    = "${data.aws_iam_policy_document.assume.json}"
  force_detach_policies = "true"
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = "${aws_iam_role.main.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "${var.principal_arns}",
      ]
    }
  }
}
