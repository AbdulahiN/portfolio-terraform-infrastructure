#EC2 Launch Configuration

resource "aws_launch_configuration" "portfolio_launch_configuration" {
  name            = "portfolio-launch-configuration"
  image_id        = data.aws_ami.server_ami.id
  instance_type   = "t2.micro"
  key_name        = "portfolio-key"
  security_groups = [aws_security_group.portfolio_security_group.id]
  user_data       = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}