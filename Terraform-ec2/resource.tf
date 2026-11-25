resource "aws_instance" "ec2-1" {
    ami = "ami-00f4e1d08499d41c3"
    instance_type = "t3.micro"
    key_name = "seoul"
    tags = {
      Name="server-1"
    }
  
}