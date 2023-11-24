#Security Group resource

resource "aws_security_group" "portfolio_security_group" {
  name        = "developer-security-group"
  description = "developer security group"
  vpc_id      = aws_vpc.portfolio_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}