terraform {
  required_version = ">= 1.3.9"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}
