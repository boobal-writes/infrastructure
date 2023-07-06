resource "aws_iam_role" "github_runner_instance_iam_role" {
  name = "github_runner_instance_iam_role"
  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          Action : "sts:AssumeRole",
          Effect : "Allow",
          Sid : "",
          Principal : {
            Service : "ec2.amazonaws.com"
          }
        }
      ]
    }
  )
}
resource "aws_iam_instance_profile" "github_runner_instance_iam_instance_profile" {
  name = "github_runner_instance_iam_instance_profile"
  role = aws_iam_role.github_runner_instance_iam_role.name
}

resource "aws_iam_role_policy" "github_runner_instance_iam_role_policy" {
  name = "github_runner_instance_iam_role_policy"
  role = aws_iam_role.github_runner_instance_iam_role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "s3:*"
        ],
        Effect : "Allow",
        Resource : "*"
      }
    ]
  })
}
