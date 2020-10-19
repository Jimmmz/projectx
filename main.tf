provider "aws" {
  region = "eu-west-2"
  version = "~>3.0"
  #   alias   = "twoseven"
}

module "db" {
  source = "./db"
  dbname = "dbserver"
}

module "eip" {
  source   = "./eip"
  eipname  = "js-eip"
  web-ID = module.web.webID
  depends_on = [module.web]  
  # james = "module.web.id"
  # instance = module.web.id
}

module "sg" {
  source = "./sg"
  sgname = "js-sg"
}

module "web" {
  source  = "./web"
  webname = "webserver"
}

output "dbIP" {
  value = module.db.dbPrvIP
}

output "www_address" {
  value = module.eip.web_address
}

output "webserver_ID" {
  value = module.web.webID
}

output "SG_name" {
  value = module.sg.sg_name
}


# variable "ingressports" {
#   type    = list(number)
#   default = [80, 443]
# }

# variable "egressports" {
#   type    = list(number)
#   default = [80, 443]
# }

# resource "aws_security_group" "websg" {
# #   provider = aws.twoseven
#   dynamic "ingress" {
#     iterator = port
#     for_each = var.ingressports
#     content {
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   dynamic "egress" {
#     iterator = port
#     for_each = var.egressports
#     content {
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }

# resource "aws_instance" "db" {
# #   provider      = aws.twoseven
#   ami           = "ami-0a13d44dccf1f5cf6"
#   instance_type = "t2.micro"
#   tags          = local.common_tags
# }

# resource "aws_instance" "web" {
#   security_groups = [aws_security_group.websg.name]
# #   provider        = aws.twoseven
#   ami             = "ami-0a13d44dccf1f5cf6"
#   instance_type   = "t2.micro"
#   user_data       = file("server-script.sh")
#   tags            = local.common_tags
# }

# resource "aws_eip" "webIP" {
# #   provider = aws.twoseven
#   instance = aws_instance.web.id
#   tags     = local.common_tags
# }

locals {
  common_tags = {
    Name  = "JStewart"
    Owner = "jstewart@hashicorp.com"
  }
}

# output "db_private_ip" {
#   value = aws_instance.db.private_ip
# }

# output "web_ip" {
#   value = aws_eip.webIP.public_ip
# }