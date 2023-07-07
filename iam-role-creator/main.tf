resource "aws_iam_policy" "iam_role_creator_policy" {
  name = "iam_role_creator_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:CreateRole"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "iam_role_creator_role" {
  name = "iam_role_creator_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_iam_role.github_runner_instance_iam_role.arn
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "iam_role_creator_policy_attachment" {
  name       = "iam_role_creator_policy_attachment"
  policy_arn = aws_iam_policy.iam_role_creator_policy.arn
  roles      = [aws_iam_role.iam_role_creator_role.name]
}

resource "aws_iam_instance_profile" "iam_role_creatore_iam_instance_profile" {
  name = "iam_role_creatore_iam_instance_profile"
  role = aws_iam_role.iam_role_creator_role.name
}
