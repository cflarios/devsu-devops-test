resource "digitalocean_loadbalancer" "public" {
  name   = "devsu"
  region = "nyc1"
  
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    
    target_port     = 80
    target_protocol = "http"
  }

  droplet_ids = digitalocean_droplet.example.*.id
}

resource "digitalocean_droplet" "example" {
  count = 2

  image  = "ubuntu-20-04-x64"
  name   = "devsu-${count.index+1}"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  user_data = "${file("userdata.yaml")}"
  ssh_keys = ["${digitalocean_ssh_key.cflarios.fingerprint}"]
}
