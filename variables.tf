variable "libvirt_uri" {
  description = "The connection URI used to connect to the libvirt host"
  type        = string
  default     = "qemu:///system"
}

variable "domain" {
  description = "Libvirt domain configuration"
  type = object({
    name            = string
    description     = optional(string)
    vcpu            = optional(number, 1)
    memory          = optional(string, "1024")
    running         = optional(bool)
    cloudinit       = optional(string)
    autostart       = optional(bool, false)
    coreos_ignition = optional(string)
    fw_cfg_name     = optional(string)
    arch            = optional(string, "x86_64")
    machine         = optional(string)
    emulator        = optional(string)
    qemu_agent      = optional(bool, false)
    type            = optional(string, "kvm")
    kernel          = optional(string)
    initrd          = optional(string)
    cmdline         = optional(list(map(string)))
    firmware        = optional(string)
    nvram = optional(object({
      file     = string
      template = string
    }))
    disk = optional(list(object({
      volume_id    = optional(string)
      url          = optional(string)
      file         = optional(string)
      block_device = optional(string)
      scsi         = optional(bool)
      wwn          = optional(bool)
    })))
    network_interface = optional(list(object({
      network_name   = optional(string)
      network_id     = optional(string)
      mac            = optional(string)
      addresses      = optional(string)
      hostname       = optional(string)
      wait_for_lease = optional(bool)
      bridge         = optional(string)
      vepa           = optional(string)
      macvtap        = optional(string)
      passthrough    = optional(string)
    })))
    graphics = optional(list(object({
      type           = optional(string, "spice")
      autoport       = optional(string, "yes")
      listen_type    = optional(string, "none")
      listen_address = optional(string, "127.0.0.1")
      websocket      = optional(string)
    })))
    console = optional(list(object({
      type           = optional(string)
      target_port    = optional(string)
      target_type    = optional(string)
      source_path    = optional(string)
      source_host    = optional(string)
      source_service = optional(string)
    })))
    cpu = optional(object({
      mode = string
    }))
    filesystem = optional(list(object({
      accessmode = optional(string, "mapped")
      source     = optional(string)
      target     = optional(string)
      readonly   = optional(bool, true)
    })))
    boot_device = optional(object({
      dev = list(string)
    }))
    tpm = optional(object({
      model                     = optional(string)
      backend_type              = optional(string, "emulator")
      backend_device_path       = optional(string)
      backend_encryption_secret = optional(string)
      backend_version           = optional(string)
      backend_persistent_state  = optional(string)
    }))
    xml = optional(object({
      xslt = string
    }))
  })
  default = null
}

variable "pools" {
  description = "Libvirt pool"
  type = list(object({
    name = string
    type = string
    path = optional(string)
    xml = optional(object({
      xslt = string
    }))
  }))
  default = []
}

variable "networks" {
  description = "Libvirt network"
  type = list(object({
    name      = string
    domain    = optional(string)
    addresses = optional(list(string))
    mode      = optional(string)
    bridge    = optional(string)
    mtu       = optional(number)
    autostart = optional(bool, false)
    routes = optional(list(object({
      cidr    = string
      gateway = string
    })), [])
    dns = optional(list(object({
      local_only = optional(bool)
      forwarders = optional(list(object({
        address = optional(string)
        domain  = optional(string)
      })))
      srvs = optional(list(object({
        service  = optional(string)
        protocol = optional(string)
        domain   = optional(string)
        target   = optional(string)
        port     = optional(string)
        weight   = optional(string)
        priority = optional(string)
      })))
      hosts = optional(list(object({
        ip       = optional(string)
        hostname = optional(string)
      })))
    })))
    dhcp = optional(object({
      enabled = optional(bool)
    }))
    dnsmasq_options = optional(object({
      options = optional(object({
        option_name  = optional(string)
        option_value = optional(string)
      }))
    }))
    xml = optional(object({
      xslt = string
    }))
  }))
  default = []
}

variable "volumes" {
  description = "Manages a storage volume"
  type = list(object({
    name             = string
    pool             = optional(string, "default")
    source           = optional(string)
    size             = optional(string)
    base_volume_id   = optional(string)
    base_volume_name = optional(string)
    base_volume_pool = optional(string)
  }))
  default = []
}

variable "ignition" {
  description = <<EOT
    Manages a CoreOS Ignition file written as a volume to 
    a libvirt storage pool that can be used to customize a 
    CoreOS Domain during first boot.
    EOT
  type = object({
    name    = string
    pool    = optional(string, "default")
    content = optional(string)
  })
  default = null
}

variable "cloudinit_disk" {
  description = <<EOT
    Manages a cloud-init ISO disk that can be used to 
    customize a domain during first boot.
    EOT
  type = object({
    name           = string
    pool           = optional(string, "default")
    user_data      = optional(string)
    meta_data      = optional(string)
    network_config = optional(string)
  })
  default = null
}