provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "example" {
    ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
    instance_type = "t2.micro"

    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                amazon-linux-extras install docker -y
                service docker start
                usermod -a -G docker ec2-user
                docker run -d --name my-awesome-portfolio -p 80:80 xavier2601/web-portfolio:v1
                EOF

    tags = {
        Name = "terraform-ec2-docker"
    }
}

output "instance_public_ip" {
    value = aws_instance.example.public_ip
}
