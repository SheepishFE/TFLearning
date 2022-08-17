resource "aws_internet_gateway" "pub-igw" {
    vpc_id  = aws_vpc.main_vpc.id
}

resource "aws_route_table" "prod-public-crt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        //can reach everywhere
        cidr_block = "0.0.0.0/0"

        //IGW uses this route for internet
        gateway_id = aws_internet_gateway.pub-igw.id
    }
}

resource "aws_route_table_association" "main-public-subnet-1" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.prod-public-crt.id
}

