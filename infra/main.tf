provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/Users/kalyangadde/.aws/credentials"]
}
/*

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"       # Search by the "Name" tag
    values = ["aws-lambda-jenkins-us-east-vpc-1"]  # Replace with your actual VPC name
  }
}

data "aws_subnet" "private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["aws-lambda-jenkins-private-subnet-1"]  # Replace with actual subnet name
  }
  vpc_id = data.aws_vpc.existing_vpc.id
}

data "aws_subnet" "private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["aws-lambda-jenkins-private-subnet-2"]  # Replace with actual subnet name
  }
  vpc_id = data.aws_vpc.existing_vpc.id
}

data "aws_security_group" "existing_sg" {
  filter {
    name   = "tag:Name"
    values = ["aws-lambda-jenkins-sg"]  # Replace with actual security group name
  }
  vpc_id = data.aws_vpc.existing_vpc.id
}


*/
resource "aws_iam_role" "lambda_role" {
 name   = "terraform_aws_lambda_role"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Add the aws_iam_policy for VPC-related permissions
resource "aws_iam_policy" "lambda_vpc_policy" {
  name        = "LambdaVpcPolicy"
  description = "Allow Lambda to create network interfaces in the VPC"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}


# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# Attach the new policy to the Lambda execution rol

resource "aws_iam_role_policy_attachment" "attach_lambda_vpc_policy" {
  policy_arn = aws_iam_policy.lambda_vpc_policy.arn
  role       = aws_iam_role.lambda_role.name
}



# Generates an archive from content, a file, or a directory of files.

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/hello-python.zip"
}

# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "terraform_lambda_func" {
 filename                       = "${path.module}/python/hello-python.zip"
 function_name                  = "aws-Lambda-Function"
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "hello-python.lambda_handler"
 runtime                        = "python3.10"
 depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role, aws_iam_role_policy_attachment.attach_lambda_vpc_policy]

 source_code_hash               = data.archive_file.zip_the_python_code.output_base64sha256

 publish = true  # This ensures a new Lambda version is created when changes occur
/*
 vpc_config {
    subnet_ids         = [data.aws_subnet.private_subnet_1.id, data.aws_subnet.private_subnet_2.id]
    security_group_ids = [data.aws_security_group.existing_sg.id]
  }*/
}


output "teraform_aws_role_output" {
 value = aws_iam_role.lambda_role.name
}

output "teraform_aws_role_arn_output" {
 value = aws_iam_role.lambda_role.arn
}

output "teraform_logging_arn_output" {
 value = aws_iam_policy.iam_policy_for_lambda.arn
}
