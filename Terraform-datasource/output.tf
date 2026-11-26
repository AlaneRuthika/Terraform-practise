output "publicip" {
    value = aws_instance.ec2-1.public_ip
  
}

output "privateip" {
    value = aws_instance.ec2-1.private_ip
  
}