provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_key_pair" "tfc_demo_key_pair" {
  key_name   = "tfc-demo-key"
  public_key = file("./tfc-demo-key.pub")
}

resource "aws_instance" "web_server" {
  ami           = "ami-0ec19a300f3097b5a"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tfc_demo_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.nginx.id]
  subnet_id     = aws_subnet.web_sever_subnet.id

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}
