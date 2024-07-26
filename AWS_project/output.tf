output "vpc_id" {
  value = aws_vpc.vpc.id

}
output "igw_id" {
  value = aws_internet_gateway.igw.id

}
output "pub_sub1" {
  value = aws_subnet.pub1.id

}
output "pub_sub2" {
  value = aws_subnet.pub2.id

}
output "pub_rt1" {
  value = aws_route_table.pub1.id

}
output "pub_rt2" {
  value = aws_route_table.pub2.id

}
output "sg_id" {
  value = aws_security_group.web_sg.id

}
output "webserver1_id" {
  value = aws_instance.webserver1.id

}
output "webserver1_pub_ip" {
  value = aws_instance.webserver1.public_ip
}
output "webserver2_id" {
  value = aws_instance.webserver2.id

}
output "webserver2_pub_ip" {
  value = aws_instance.webserver2.public_ip
}
output "lb_sg" {
  value = aws_security_group.lb_sg.id

}
output "albdns" {
  value = aws_lb.test.dns_name

}

