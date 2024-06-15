resource "libvirt_ignition" "this" {
  count = var.ignition != null ? 1 : 0

  name    = var.ignition.name
  pool    = var.ignition.pool
  content = var.ignition.content
}