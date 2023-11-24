#Internet Gateway resource

resource "aws_internet_gateway" "portfolio_gateway" {
  vpc_id = aws_vpc.portfolio_vpc.id

  tags = {
    Name = "developer-igw"
  }
}
