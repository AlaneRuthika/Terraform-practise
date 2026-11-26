resource "aws_instance" "ec2-2" {
    ami = "ami-00f4e1d08499d41c3"
    key_name = "seoul"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.sg-nginx.id ]
    user_data = <<-EOF
    #!\bin\bash
    sudo -i
    yum update -y
    yum install nginx -y
    systemctl start nginx
    cd /usr/share/nginx/html/
    systemctl status nginx
    systemctl restart nginx
    

    EOF
    tags = {
      Name="ec2-2"
    }
  
}

resource "aws_security_group" "sg-nginx" {
    name = "nginx-1"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}