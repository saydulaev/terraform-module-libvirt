output "domain_id" {
  description = "Libvirt domain id"
  value       = one(libvirt_domain.this[*].id)
}

output "domain" {
  description = "Libvirt domain full outcome"
  value       = one(libvirt_domain.this)
}

output "pools_id" {
  description = "Libvirt pool id"
  value       = values(libvirt_pool.this)[*].id
}

output "pools" {
  description = "Map of Libvirt {pool.name =  pool.id} objects"
  value = {
    for p in var.pools : p.name => libvirt_pool.this[p.name].id if length(var.pools) > 0
  }
}

output "networks_id" {
  description = "Libvirt network id"
  value       = values(libvirt_network.this)[*].id
}

output "networks" {
  description = "Map of Libvirt {network.name = network.id} objects"
  value = {
    for net in var.networks : net.name => libvirt_network.this[net.name].id if length(var.networks) > 0
  }
}

output "ignition_id" {
  description = "CoreOS Ignition id"
  value       = one(libvirt_ignition[*].id)
}

output "volumes_id" {
  description = "Libvirt volume id"
  value       = values(libvirt_volume.this)[*].id
}

output "volumes" {
  description = "Map of Libvirt {volume.name = volume.id} objects"
  value = {
    for v in var.volumes : v.name => libvirt_volume.this[v.name].id if length(var.volumes) > 0
  }
}

output "cloudinit_disk_id" {
  description = "Libvirt cloudinit disk id"
  value       = one(libvirt_cloudinit_disk[*].id)
}
