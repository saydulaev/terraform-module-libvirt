resource "libvirt_pool" "this" {
  for_each = {
    for pool in var.pools : pool.name => pool
    if length(var.pools) > 0
  }

  name = each.value.name
  type = try(each.value.type, "dir")
  path = try(each.value.path, null)
  dynamic "xml" {
    for_each = each.value.xml != null ? [1] : []
    content {
      xslt = each.value.xml.xslt
    }
  }
}
