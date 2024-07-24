output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "subnet_id" {
    value = aws_subnet.public.id
  
}
output "igw_id" {
    value = aws_internet_gateway.igw.id
  
}
output "route_table_id" {
    value = aws_route_table.public_RT.id
  
}
output "instance_id" {
    value = aws_instance.instance.id
  
}
output "instance_public_ip" {
    value = aws_instance.instance.public_ip
  
}
