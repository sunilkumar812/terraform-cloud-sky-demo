resource "aws_ec2_instance_state" "start_instance" {
  instance_id = aws_instance.first-tf-web-server.id
  state       = "running"
}
