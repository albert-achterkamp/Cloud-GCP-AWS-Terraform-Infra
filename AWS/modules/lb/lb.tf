
resource "aws_launch_configuration" "webserver" {
  name_prefix = "webserver-"

  image_id = var.image
  instance_type = var.instance_type
  # key_name = "Lenovo T410"

  security_groups = [ var.sg-allow-http.id ]
  # security_groups = [ module.vpc.sg-allow-http.id ]


  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
yum update
yum -y install nginx
echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" > /usr/share/nginx/html/index.html
chkconfig nginx on
service nginx start
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}


# module "vpc" {
#   count = var.create_default_vpc ? 1:0
#   source = "../vpc"
#   region = var.region
#   zones = var.zones
# }








