resource "digitalocean_loadbalancer" "public" {
  name   = "devsu"
  region = "nyc1"
  
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    
    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
    check_interval_seconds = 10
    response_timeout_seconds = 10
  }

  droplet_ids = digitalocean_droplet.example.*.id
}

resource "digitalocean_droplet" "example" {
  count = 2

  image  = "ubuntu-20-04-x64"
  name   = "devsu-${count.index+1}"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.cflarios.fingerprint}"]

  connection {
    type = "ssh"
    user = "root"
    private_key = file("~/.ssh/id_rsa")
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do sleep 1 ; done",
      "sudo apt install -y docker.io",
      "sudo docker run -d -p 80:3001 cflarios/devsu_devops_assessment:latest"
    ]
  }
}
