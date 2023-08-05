resource "aws_ecr_repository" "allowlist" {
  name = "skills-allowlist"
  force_delete = true
}

resource "aws_ecr_repository" "event" {
  name = "skills-event"
  force_delete = true
}

resource "aws_ecr_repository" "user" {
  name = "skills-user"
  force_delete = true
}
