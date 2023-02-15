# Export SSH key

resource "digitalocean_ssh_key" "cflarios" {
    name = "cflarios"
    public_key = "${file("~/.ssh/id_rsa.pub")}"
    }