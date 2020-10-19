variable "eipname" {
  type = string
}

variable "web-ID" {
  type = string
  # default = module.web.webID
}
   
# variable "james" {
#   type = string
# }

resource "aws_eip" "webIP" {
  # instance = var.web-ID
  tags = {
    Name = var.eipname
  }
  #   tags     = local.common_tags
}

output "web_address" {
  value = aws_eip.webIP.public_ip
}