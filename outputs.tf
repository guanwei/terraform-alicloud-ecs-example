output "vpc_id" {
  value = "${data.alicloud_vpcs.default.vpcs.0.id}"
}

output "zone_id" {
  value = "${data.alicloud_zones.default.zones.0.id}"
}

output "vswitch_id" {
  value = "${data.alicloud_vswitches.default.vswitches.0.id}"
}

output "security_group_id" {
  value = "${alicloud_security_group.group.id}"
}

output "ecs_names" {
  value = "${join(",", alicloud_instance.instance.*.instance_name)}"
}

output "ecs_ids" {
  value = "${join(",", alicloud_instance.instance.*.id)}"
}

output "ecs_public_ips" {
  value = "${join(",", alicloud_instance.instance.*.public_ip)}"
}

output "ecs_tags" {
  value = "${jsonencode(alicloud_instance.instance.*.tags)}"
}
