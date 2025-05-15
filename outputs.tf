output "ELB_DNS" {
  value = "${aws_elb.default.dns_name}"
}


output "MYSQL_DNS" {
  value = "${aws_db_instance.default.db_name}"
}
