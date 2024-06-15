### Terraform module to manage Libvirt domain,pools,volumes,networks,ignition and cloudinit.

```bash
// Macos
libvirt_uri = "qemu:///session?socket=/usr/local/var/run/libvirt/libvirt-sock"

pools = [
  {
    name = "ssd"
    type = "dir"
    path = "/data/libvirt/ssd"
  }
]

networks = [
  {
    name      = "networktest"
    mode      = "nat"
    domain    = "k8s.local"
    addresses = ["10.17.3.0/24"]
    dhcp = {
      enabled = true
    }
  }
]

volumes = [
  {
    name = "boot"
    pool = "ssd"
    size = "20G"
  },
  {
    name = "data"
    pool = "nvme"
    size = "20G"
  }
]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | 0.7.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_libvirt"></a> [libvirt](#provider\_libvirt) | 0.7.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.commoninit](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/cloudinit_disk) | resource |
| [libvirt_domain.this](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/domain) | resource |
| [libvirt_ignition.this](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/ignition) | resource |
| [libvirt_network.this](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/network) | resource |
| [libvirt_pool.this](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/pool) | resource |
| [libvirt_volume.this](https://registry.terraform.io/providers/dmacvicar/libvirt/0.7.6/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudinit_disk"></a> [cloudinit\_disk](#input\_cloudinit\_disk) | Manages a cloud-init ISO disk that can be used to <br>    customize a domain during first boot. | <pre>object({<br>    name           = string<br>    pool           = optional(string, "default")<br>    user_data      = optional(string)<br>    meta_data      = optional(string)<br>    network_config = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Libvirt domain configuration | <pre>object({<br>    name            = string<br>    description     = optional(string)<br>    vcpu            = optional(number, 1)<br>    memory          = optional(string, "1024")<br>    running         = optional(bool)<br>    cloudinit       = optional(string)<br>    autostart       = optional(bool, false)<br>    coreos_ignition = optional(string)<br>    fw_cfg_name     = optional(string)<br>    arch            = optional(string, "x86_64")<br>    machine         = optional(string)<br>    emulator        = optional(string)<br>    qemu_agent      = optional(bool, false)<br>    type            = optional(string, "kvm")<br>    kernel          = optional(string)<br>    initrd          = optional(string)<br>    cmdline         = optional(list(map(string)))<br>    firmware        = optional(string)<br>    nvram = optional(object({<br>      file     = string<br>      template = string<br>    }))<br>    disk = optional(list(object({<br>      volume_id    = optional(string)<br>      url          = optional(string)<br>      file         = optional(string)<br>      block_device = optional(string)<br>      scsi         = optional(bool)<br>      wwn          = optional(bool)<br>    })))<br>    network_interface = optional(list(object({<br>      network_name   = optional(string)<br>      network_id     = optional(string)<br>      mac            = optional(string)<br>      addresses      = optional(string)<br>      hostname       = optional(string)<br>      wait_for_lease = optional(bool)<br>      bridge         = optional(string)<br>      vepa           = optional(string)<br>      macvtap        = optional(string)<br>      passthrough    = optional(string)<br>    })))<br>    graphics = optional(list(object({<br>      type           = optional(string, "spice")<br>      autoport       = optional(string, "yes")<br>      listen_type    = optional(string, "none")<br>      listen_address = optional(string, "127.0.0.1")<br>      websocket      = optional(string)<br>    })))<br>    console = optional(list(object({<br>      type           = optional(string)<br>      target_port    = optional(string)<br>      target_type    = optional(string)<br>      source_path    = optional(string)<br>      source_host    = optional(string)<br>      source_service = optional(string)<br>    })))<br>    cpu = optional(object({<br>      mode = string<br>    }))<br>    filesystem = optional(list(object({<br>      accessmode = optional(string, "mapped")<br>      source     = optional(string)<br>      target     = optional(string)<br>      readonly   = optional(bool, true)<br>    })))<br>    boot_device = optional(object({<br>      dev = list(string)<br>    }))<br>    tpm = optional(object({<br>      model                     = optional(string)<br>      backend_type              = optional(string, "emulator")<br>      backend_device_path       = optional(string)<br>      backend_encryption_secret = optional(string)<br>      backend_version           = optional(string)<br>      backend_persistent_state  = optional(string)<br>    }))<br>    xml = optional(object({<br>      xslt = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_ignition"></a> [ignition](#input\_ignition) | Manages a CoreOS Ignition file written as a volume to <br>    a libvirt storage pool that can be used to customize a <br>    CoreOS Domain during first boot. | <pre>object({<br>    name    = string<br>    pool    = optional(string, "default")<br>    content = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_libvirt_uri"></a> [libvirt\_uri](#input\_libvirt\_uri) | The connection URI used to connect to the libvirt host | `string` | `"qemu:///system"` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Libvirt network | <pre>list(object({<br>    name      = string<br>    domain    = optional(string)<br>    addresses = optional(list(string))<br>    mode      = optional(string)<br>    bridge    = optional(string)<br>    mtu       = optional(number)<br>    autostart = optional(bool, false)<br>    routes = optional(list(object({<br>      cidr    = string<br>      gateway = string<br>    })), [])<br>    dns = optional(list(object({<br>      local_only = optional(bool)<br>      forwarders = optional(list(object({<br>        address = optional(string)<br>        domain  = optional(string)<br>      })))<br>      srvs = optional(list(object({<br>        service  = optional(string)<br>        protocol = optional(string)<br>        domain   = optional(string)<br>        target   = optional(string)<br>        port     = optional(string)<br>        weight   = optional(string)<br>        priority = optional(string)<br>      })))<br>      hosts = optional(list(object({<br>        ip       = optional(string)<br>        hostname = optional(string)<br>      })))<br>    })))<br>    dhcp = optional(object({<br>      enabled = optional(bool)<br>    }))<br>    dnsmasq_options = optional(object({<br>      options = optional(object({<br>        option_name  = optional(string)<br>        option_value = optional(string)<br>      }))<br>    }))<br>    xml = optional(object({<br>      xslt = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_pools"></a> [pools](#input\_pools) | Libvirt pool | <pre>list(object({<br>    name = string<br>    type = string<br>    path = optional(string)<br>    xml = optional(object({<br>      xslt = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Manages a storage volume | <pre>list(object({<br>    name             = string<br>    pool             = optional(string, "default")<br>    source           = optional(string)<br>    size             = optional(string)<br>    base_volume_id   = optional(string)<br>    base_volume_name = optional(string)<br>    base_volume_pool = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudinit_disk_id"></a> [cloudinit\_disk\_id](#output\_cloudinit\_disk\_id) | Libvirt cloudinit disk id |
| <a name="output_domain"></a> [domain](#output\_domain) | Libvirt domain full outcome |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Libvirt domain id |
| <a name="output_ignition_id"></a> [ignition\_id](#output\_ignition\_id) | CoreOS Ignition id |
| <a name="output_networks"></a> [networks](#output\_networks) | Map of Libvirt {network.name = network.id} objects |
| <a name="output_networks_id"></a> [networks\_id](#output\_networks\_id) | Libvirt network id |
| <a name="output_pools"></a> [pools](#output\_pools) | Map of Libvirt {pool.name =  pool.id} objects |
| <a name="output_pools_id"></a> [pools\_id](#output\_pools\_id) | Libvirt pool id |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | Map of Libvirt {volume.name = volume.id} objects |
| <a name="output_volumes_id"></a> [volumes\_id](#output\_volumes\_id) | Libvirt volume id |
<!-- END_TF_DOCS -->
