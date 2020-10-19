variable "sgname" {
  type = string
}

variable "ingressports" {
  type    = list(number)
  default = [80, 443]
}

variable "egressports" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "websg" {
  #   provider = aws.twoseven
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = var.sgname
  }
}

output "sg_name" {
  value = aws_security_group.websg.name
}