variable “ncloud_zones” {
type = “list”
default = [“KR-1”, “KR-2”]
}

variable “server_image_prodict_code” {
default = “SPSW0LINUX000032”
}

variable “server_product_code” {
default = “SPSVRSTAND000004”
}

# keypair create
resource “ncloud_login_key” “loginkey” {
“key_name” = “webinar”
}

​

data “template_file” “user_data” {
template = “${file(“user-data.sh”)}”
}

#server create
resource “ncloud_server” “server” {
“count” = “2”
“server_name” = “tf-webinar-vm-${count.index+1}”
“server_image_product_code” = “${var.server_image_prodict_code}”
“server_product_code” = “${var.server_product_code}”
“server_description” = “tf-webinar-vm-${count.index+1}”
“login_key_name” = “${ncloud_login_key.loginkey.key_name}”
“access_control_group_configuration_no_list” = [“13054”]
“zone_code” = “${var.ncloud_zones[count.index]}”
“user_data” = “${data.template_file.user_data.rendered}”
}