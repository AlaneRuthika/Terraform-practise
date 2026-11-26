resource "aws_instance" "ec2-1" {
    ami = data.aws_ami.linux.id
    instance_type = var.instance_type
    key_name = "seoul"
    user_data = file("apache-install.sh")
    vpc_security_group_ids = [aws_security_group.ssh.id,aws_security_group.web.id]
    tags = {
      Name="linux-1"
    }

  
}