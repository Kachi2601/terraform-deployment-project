# Data block to fetch the existing security group
data "aws_security_group" "existing_web_sg" {
  filter {
    name   = "group-name"
    values = ["web-sg"]  # Name of your existing security group
  }
}

resource "aws_instance" "web_instance" {
    ami = "ami-08f78cb3cc8a4578e" # Amazon Linux 2 AMI
    instance_type = "t3.micro"
    
     # Reference the existing security group from the data block
    security_groups = [data.aws_security_group.existing_web_sg.name]

    tags = {
        Name = "WebServer"
    }
}