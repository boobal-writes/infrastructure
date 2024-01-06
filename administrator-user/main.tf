resource "aws_iam_group" "administrators" {
  name = "Administrators"
  path = "/"
}

data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group      = aws_iam_group.administrators.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

resource "aws_iam_user" "administrator" {
  name = "Administrator"
}

resource "aws_iam_user_group_membership" "administrator_group_membership" {
  user   = aws_iam_user.administrator.name
  groups = [aws_iam_group.administrators.name]
}
