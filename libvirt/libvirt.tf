terraform {
 required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.2"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}


resource "libvirt_domain" "bionic-from-terraform" {
  name   = "bionic-from-terraform"
  memory = "2048"
  vcpu   = 4
  cloudinit = libvirt_cloudinit_disk.commoninit-bionic.id

  network_interface {
    bridge = "br0"
    # If forcing a MAC addresss is needed...
    #mac = "52:54:00:f2:01:0e"
  }

  disk {
    volume_id = libvirt_volume.bionic-terraform-qcow2-resized.id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

}

resource "libvirt_volume" "bionic-terraform-qcow2" {
  name = "bionic-terraform.qcow2"
  pool = "default"
  source = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  format = "qcow2"
}

resource "libvirt_volume" "bionic-terraform-qcow2-resized" {
  name           = "disk"
  base_volume_id = libvirt_volume.bionic-terraform-qcow2.id
  pool           = "default"
  size           = 19084179456  # roughly 16 GB
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}


# Use CloudInit to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit-bionic" {
  name           = "commoninit-bionic.iso"
  user_data      = data.template_file.user_data.rendered

#  If using extended net config file, really - not a must. 
#  network_config = data.template_file.network_config.rendered
}

