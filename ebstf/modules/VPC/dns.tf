resource "aws_route53_zone" "private_mgmt" {
    name = "mgmt.test.com"
    comment = "Private DNS Zone for testing"

    vpc {
        vpc_id = aws_vpc.main_vpc.id
    }

}