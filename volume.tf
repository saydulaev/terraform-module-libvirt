resource "libvirt_volume" "this" {
  for_each = {
    for volume in var.volumes : volume.name => volume
    if length(var.volumes) > 0
  }

  name             = each.value.name
  pool             = try(each.value.pool, null)
  source           = try(each.value.source, null)
  size             = try(each.value.size, null)
  base_volume_id   = try(each.value.base_volume_id, null)
  base_volume_name = try(each.value.base_volume_name, null)
  base_volume_pool = try(each.value.base_volume_pool, null)
  dynamic "xml" {
    for_each = each.value.xml != null ? [1] : []
    content {
      xslt = each.value.xml.xslt
    }
  }
}
