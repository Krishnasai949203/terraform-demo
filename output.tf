output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "igw_id" {
    value = aws_internet_gateway.gw.id 
}
output "public_subnet_id" {
    value = aws_subnet.public.id 
}
output "private_subnet_id" {
    value = aws_subnet.private.id
}
output "public_route" {
    value = aws_route_table.public.id
  
}
output "private_route" {
    value = aws_route_table.private.id
}
output "instance_id" {
    value = aws_instance.test.id
  
}