resource "aws_instance" "demo"{
   ami = "ami-0639df93102b03fec"
   instance_type = "t3.micro"
   key_name = "project-2"
tags ={
Name = "ec2-terraform"
}
}
 
