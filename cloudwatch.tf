provider "aws" {
    region = "us-east-1"
}


resource "aws_cloudwatch_log_group" "example" {
    name              = "/aws/ec2/example-instance"
    retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "example" {
    name           = "example-log-stream"
    log_group_name = aws_cloudwatch_log_group.example.name
}

resource "aws_iam_role" "cloudwatch_role" {
    name = "cloudwatch-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_policy" "cloudwatch_policy" {
    name        = "cloudwatch-policy"
    description = "Policy to allow EC2 to write to CloudWatch Logs"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action   = [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ]
                Effect   = "Allow"
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
    role       = aws_iam_role.cloudwatch_role.name
    policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

resource "aws_instance" "example_with_role" {
    ami           = "ami-0c55b159cbfafe1f0" # Replace with your desired AMI ID
    instance_type = "t2.micro"

    iam_instance_profile = aws_iam_instance_profile.cloudwatch_profile.name

    tags = {
        Name = "example-instance-with-role"
    }
}

resource "aws_iam_instance_profile" "cloudwatch_profile" {
    name = "cloudwatch-instance-profile"
    role = aws_iam_role.cloudwatch_role.name
}