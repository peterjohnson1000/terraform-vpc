terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
    cidr_block = "18.0.0.0/20"
}

# us-east-1a
resource "aws_subnet" "public_subnet_one" {
    vpc_id     = aws_vpc.main_vpc.id
    cidr_block = "18.0.0.0/23"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_one" {
    vpc_id     = aws_vpc.main_vpc.id
    cidr_block = "18.0.2.0/23"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}

# us-east-1b
resource "aws_subnet" "public_subnet_two" {
    vpc_id     = aws_vpc.main_vpc.id
    cidr_block = "18.0.4.0/23"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_two" {
    vpc_id     = aws_vpc.main_vpc.id
    cidr_block = "18.0.6.0/23"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
}

# igw
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_instance" "test-server" {
    ami = ""
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet_one.id
}