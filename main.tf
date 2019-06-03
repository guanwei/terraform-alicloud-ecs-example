provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

data "alicloud_vpcs" "default" {
  name_regex = "^${var.vpc_name}$"
  status = "Available"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.t5"
  cpu_core_count       = 1
  memory_size          = 2
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
  available_instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"
}

data "alicloud_vswitches" "default" {
  zone_id = "${data.alicloud_zones.default.zones.0.id}"
  vpc_id = "${data.alicloud_vpcs.default.vpcs.0.id}"
}

resource "alicloud_security_group" "group" {
  name   = "${var.app_name}-${var.env_name}"
  vpc_id = "${data.alicloud_vpcs.default.vpcs.0.id}"
}

resource "alicloud_security_group_rule" "allow_tcp_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "instance" {
  instance_name   = "${var.app_name}-${var.env_name}-${format(var.count_format, count.index+1)}"
  host_name       = "${var.app_name}-${var.env_name}-${format(var.count_format, count.index+1)}"
  image_id        = "${var.image_id}"
  instance_type   = "${data.alicloud_instance_types.default.instance_types.0.id}"
  count           = "${var.count}"
  security_groups = ["${alicloud_security_group.group.*.id}"]
  vswitch_id      = "${data.alicloud_vswitches.default.vswitches.0.id}"

  internet_charge_type       = "${var.internet_charge_type}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"

  password = "${var.password}"

  instance_charge_type = "${var.instance_charge_type}"
  system_disk_category = "${var.system_disk_category}"

  tags {
    app = "${var.app_name}"
    env = "${var.env_name}"
  }

  user_data = "${file("userdata.sh")}"
}