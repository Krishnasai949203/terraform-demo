output "My_instance_instance_ids" {
    value = aws_instance.My_instance[*].id
    description = "My_instance"
  
}
output "My_instance_instance_public_ips" {
    value = aws_instance.My_instance.*.public_ip
  
}
output "krishna_instance_ids" {
    value =  aws_instance.krishna[*].id
  
}
output "krishna_instance_public_ips" {
    value = aws_instance.krishna.*.public_ip
  
}
