provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "example" {
    ami           = "ami-08f78cb3cc8a4578e" # Amazon Linux 2 AMI
    instance_type = "t3.micro"
    vpc_security_group_ids = [data.aws_security_group.existing_web_sg.id]

    
    user_data = <<-EOF
                #!/bin/bash
                sudo dnf install docker -y
                sudo systemctl enable docker
                sudo systemctl start docker
                sudo usermod -aG docker ec2-user
                sudo docker run -d -p 80:80 xavier2601/web-portfolio:v1
                EOF

    tags = {
        Name = "terraform-ec2-docker"
    }
}

output "instance_public_ip" {
    value = aws_instance.example.public_ip
}
