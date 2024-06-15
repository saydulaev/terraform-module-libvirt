resource "libvirt_domain" "this" {
  count = var.domain != null ? 1 : 0

  name            = var.domain.name
  description     = try(var.domain.description, null)
  vcpu            = try(var.domain.vcpu, null)
  memory          = try(var.domain.memory, null)
  running         = try(var.domain.running, null)
  cloudinit       = try(var.domain.cloudinit, null)
  autostart       = try(var.domain.autostart, false)
  coreos_ignition = try(var.domain.coreos_ignition, null)
  fw_cfg_name     = try(var.domain.fw_cfg_name, null)
  arch            = try(var.domain.arch, "x86_64")
  machine         = try(var.domain.machine, null)
  emulator        = try(var.domain.emulator, null)
  qemu_agent      = try(var.domain.qemu_agent, null)
  type            = try(var.domain.type, "kvm")
  kernel          = try(var.domain.kernel, null)
  initrd          = try(var.domain.initrd, null)
  cmdline         = try(var.domain.cmdline, null)
  firmware        = try(var.domain.firmware.firmware, null)
  dynamic "nvram" {
    for_each = var.domain.nvram != null ? [1] : []
    content {
      file     = var.domain.nvram.file
      template = var.domain.nvram.template
    }
  }
  dynamic "disk" {
    for_each = length(try(var.domain.disk, [])) > 0 ? var.domain.disk : []
    content {
      volume_id    = try(disk.value.volume_id, null)
      url          = try(disk.value.url, null)
      file         = try(disk.value.file, null)
      block_device = try(disk.value.block_device, null)
      scsi         = try(disk.value.scsi, null)
      wwn          = try(disk.value.wwn, null)
    }
  }
  dynamic "network_interface" {
    for_each = length(try(var.domain.network_interface, [])) > 0 ? var.domain.network_interface : []
    iterator = interface
    content {
      network_name   = try(interface.value.network_name, null)
      network_id     = try(interface.value.network_id, null)
      mac            = try(interface.value.mac, null)
      addresses      = try(interface.value.addresses, null)
      hostname       = try(interface.value.hostname, null)
      wait_for_lease = try(interface.value.wait_for_lease, null)
      bridge         = try(interface.value.bridge, null)
      vepa           = try(interface.value.vepa, null)
      macvtap        = try(interface.value.macvtap, null)
      passthrough    = try(interface.value.passthrough, null)
    }
  }
  dynamic "graphics" {
    for_each = length(try(var.domain.graphics, [])) > 0 ? var.domain.graphics : []
    content {
      type           = try(graphics.value.type, null)
      autoport       = try(graphics.value.autoport, null)
      listen_type    = try(graphics.value.listen_type, null)
      listen_address = try(graphics.value.listen_address, null)
      websocket      = try(graphics.value.websocket, null)
    }
  }
  dynamic "console" {
    for_each = var.domain.console != null ? var.domain.console : []
    content {
      type           = each.value.console.type
      target_port    = each.value.console.target_port
      target_type    = try(each.value.target_type, null)
      source_path    = try(source_path, null)
      source_host    = try(source_host, null)
      source_service = try(source_service, null)
    }
  }
  dynamic "cpu" {
    for_each = var.domain.cpu != null ? [1] : []
    content {
      mode = var.domain.cpu.mode
    }
  }
  dynamic "filesystem" {
    for_each = length(try(var.domain.filesystem, [])) > 0 ? var.domain.filesystem : []
    content {
      accessmode = filesystem.value.accessmode
      source     = filesystem.value.source
      target     = filesystem.value.target
      readonly   = filesystem.value.readonly
    }
  }
  dynamic "boot_device" {
    for_each = var.domain.boot_device != null ? [1] : []
    content {
      dev = var.domain.boot_device.dev
    }
  }
  dynamic "tpm" {
    for_each = var.domain.tpm != null ? [1] : []
    content {
      model                     = try(tpm.value.model, null)
      backend_type              = try(tpm.value.backend_type, null)
      backend_device_path       = try(tpm.value.backend_device_path, null)
      backend_encryption_secret = try(tpm.value.backend_encryption_secret, null)
      backend_version           = try(tpm.value.backend_version, null)
      backend_persistent_state  = try(tpm.value.backend_persistent_state, null)
    }
  }
  dynamic "xml" {
    for_each = var.domain.xml != null ? [1] : []
    content {
      xslt = var.domain.xml.xslt
    }
  }
}
