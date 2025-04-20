provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "example" {
    ami           = "ami-08f78cb3cc8a4578e" # Amazon Linux 2 AMI
    instance_type = "t3.micro"
    security_groups = [data.aws_security_group.existing_web_sg.name]

    
    user_data = <<-EOF
                            #!/bin/bash
                            yum update -y
                            amazon-linux-extras install docker -y
                            service docker start
                            usermod -a -G docker ec2-user
                            docker run -d --name my-awesome-app -p 80:80 xavier2601/web-portfolio:v1
                            EOF

    tags = {
        Name = "terraform-ec2-docker"
    }
}

output "instance_public_ip" {
    value = aws_instance.example.public_ip
}