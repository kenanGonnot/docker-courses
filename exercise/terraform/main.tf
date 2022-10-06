terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.6.0"
    }
  }
  required_version = ">= 0.13"
}

variable "do_token" {}
variable "private_key {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "terraform"
}

resource "digitalocean_droplet" "docker" {
  name     = "docker"
  image    = "ubuntu-20-04-x64"
  region   = "lon1"
  size     = "s-2vcpu-4gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.private_key)
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "curl -sSL https://get.docker.com | sh"
    ]
  }
}

output "droplet" {
    value = digitalocean_droplet.docker.ipv4_address
}
