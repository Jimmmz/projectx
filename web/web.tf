variable "webname" {
  type = string
}

resource "aws_instance" "web" {
  # security_groups = [aws_security_group.websg.name]
  #   provider        = aws.twoseven
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
  user_data     = file("./server-script.sh")
  tags = {
    Name = var.webname
  }
  # tags            = local.common_tags
}

output "webID" {
  value = aws_instance.web.id
}
