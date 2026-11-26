resource "aws_instance" "ec2-exp" {
    ami ="ami-0a1a0c4fe286aaf02"
    instance_type = "t3.micro"
    key_name = "seoul"
    vpc_security_group_ids = [ aws_security_group.sg-1.id ]
    user_data = <<-EOF
    #!/bin/bash
    sudo -i
    apt update -y
    apt install apache2 -y
    apt install -y httpd
    cd /var/www/html
    systemctl enable http
    EOF
}

resource "aws_security_group" "sg-1" {
    name = "server-1sg"
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