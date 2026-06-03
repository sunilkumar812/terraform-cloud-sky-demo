#EC2 Resouce TF Configuration

resource "aws_instance" "first-tf-web-server" {
  ami           = "ami-045443a70fafb8bbc"
  instance_type = "t3.micro"

  tags = {
    Name  = "First-TF-Amazion-Linux-Server"
    Owner = "Sunil-Kumar-DevOps-Engg"
  }
}
