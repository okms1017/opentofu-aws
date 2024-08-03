data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

variable "instance_tags" {
  type = list(string)
  default = ["web", "app"]
}

resource "aws_instance" "this" {
  count = length(var.instance_tags)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"

  tags = {
    Name = var.instance_tags[count.index]
    Env = "dev"
  }
}