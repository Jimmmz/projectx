variable "dbname" {
  type = string
}

resource "aws_instance" "db" {
  #   provider      = aws.twoseven
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
  tags = {
    Name = var.dbname
  }
  # tags          = local.common_tags
}

output "dbPrvIP" {
  value = aws_instance.db.private_ip
}
