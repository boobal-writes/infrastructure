variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-south-1"
}

variable "infrastrucute_repo_personal_access_token" {
  description = "GitHub Personal Access Token to call GitHub API and get token for registering runners"
}
