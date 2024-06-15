resource "libvirt_cloudinit_disk" "commoninit" {
  count = var.cloudinit_disk != null ? 1 : 0

  name           = var.cloudinit_disk
  pool           = var.cloudinit_disk.pool
  user_data      = var.cloudinit_disk
  meta_data      = var.cloudinit_disk.meta_data
  network_config = var.cloudinit_disk.network_config
}