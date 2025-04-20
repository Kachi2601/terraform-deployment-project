resource "aws_security_group" "web_sg" {
    name        = "web-sg"
    description = "Allow inbound and outbound traffic on port 80"
    vpc_id      = "your-vpc-id" # Replace with your VPC ID
  
    ingress {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow inbound HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow outbound HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web_instance" {
    ami = "ami-08f78cb3cc8a4578e" # Amazon Linux 2 AMI
    instance_type = "t3.micro"
    security_groups = [aws_security_group.web_sg.name]

    tags = {
        Name = "WebServer"
    }
}