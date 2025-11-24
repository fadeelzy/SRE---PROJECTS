resource "aws_instance" "docker_host" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_1.id
  security_groups = [aws_security_group.app_sg.id]

  user_data = <<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
docker run -d -p 80:80 nginx
EOF

  tags = { Name = "docker-host" }
}
