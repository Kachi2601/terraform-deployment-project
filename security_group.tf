# Data block to fetch the existing security group
data "aws_security_group" "existing_web_sg" {
  filter {
    name   = "group-name"
    values = ["web-sg"]  # Name of your existing security group
  }
}
