resource "libvirt_network" "this" {
  for_each = {
    for net in var.networks : net.name => net
    if length(var.networks) > 0
  }

  name      = each.value.name
  domain    = try(each.value.domain, null)
  addresses = try(each.value.addresses, null)
  dynamic "dns" {
    for_each = each.value.dns != null ? [1] : []
    content {
      local_only = try(each.value.dns.local_only, null)
      dynamic "forwarders" {
        for_each = length(try(each.value.dns.forwarders, [])) > 0 ? each.value.dns.forwarders : []
        iterator = forwarder
        content {
          address = try(forwarder.value.address, null)
          domain  = try(forwarder.value.domain, null)
        }
      }
      dynamic "srvs" {
        for_each = length(try(each.value.dns.srvs, [])) > 0 ? each.value.dns.srvs : []
        iterator = srv
        content {
          service  = try(srv.value.service, null)
          protocol = try(srv.value.protocol, null)
          domain   = try(srv.value.domain, null)
          target   = try(srv.value.target, null)
          port     = try(srv.value.port, null)
          weight   = try(srv.value.weight, null)
          priority = try(srv.value.priority, null)
        }
      }
      dynamic "hosts" {
        for_each = length(try(each.value.dns.hosts, [])) > 0 ? each.value.dns.hosts : []
        iterator = host
        content {
          ip       = try(host.value.ip, null)
          hostname = try(host.value.hostname, null)
        }
      }
    }
  }
  dynamic "dhcp" {
    for_each = each.value.dhcp != null ? [1] : []
    content {
      enabled = try(each.value.dhcp.enabled)
    }
  }
  dynamic "routes" {
    for_each = length(try(each.value.routes, [])) > 0 ? each.value.routes : []
    iterator = route
    content {
      cidr    = route.value.cidr
      gateway = route.value.gateway
    }
  }
  dynamic "dnsmasq_options" {
    for_each = each.value.dnsmasq_options != null ? [1] : []
    content {
      dynamic "options" {
        for_each = length(try(each.value.dnsmasq_options.options, [])) > 0 ? each.value.dnsmasq_options.options : []
        iterator = option
        content {
          option_name  = try(option.value.option_name, null)
          option_value = try(option.value.option_value, null)
        }
      }
    }
  }
  dynamic "xml" {
    for_each = each.value.xml != null ? [1] : []
    content {
      xslt = each.value.xml.xslt
    }
  }
}