resource "aws_vpc" "main_vpc" { 
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" { 
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}

output "vpc_id" {
    value = aws_vpc.main_vpc.id
  
}

output "vpc_cidr" {
  value = aws_vpc.main_vpc.cidr_block
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}