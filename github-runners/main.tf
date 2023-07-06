resource "aws_instance" "github_runner_instance" {
  vpc_security_group_ids = [aws_security_group.github_runner_security_group.id]
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.micro"
  user_data              = templatefile("scripts/setup.sh", { personal_access_token = var.infrastrucute_repo_personal_access_token })
  tags = {
    name = "github-runner"
    type = "terraform"
  }
}
