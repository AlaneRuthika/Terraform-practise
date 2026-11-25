resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "vpc-1"
    }
  
}
 
#public subnet
resource "aws_subnet" "pub-sub" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true
    tags = {
      Name="publicsub"
    }
}

#private subnet
resource "aws_subnet" "pri-sub" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2b"
    tags = {
      Name="privatesub"
    }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-1.id
    tags = {
      Name="igw-1"
    }
}

#nat gateway
resource "aws_nat_gateway" "nat" {
    subnet_id = aws_subnet.pri-sub.id
    allocation_id = aws_eip.nat_eip.id
    tags = {
      Name="nat-1"
    }
    depends_on = [ aws_internet_gateway.igw ] 
}
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

#public route table 
resource "aws_route_table" "publicroute" {
    vpc_id = aws_vpc.vpc-1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name="publicroute-1"
    }
  
}

#private route
resource "aws_route_table" "privateroute" {
    vpc_id = aws_vpc.vpc-1.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name="privateroute-1"
    }
  
}
#route table associate public
resource "aws_route_table_association" "publicrouteassoc" {
    subnet_id = aws_subnet.pub-sub.id
    route_table_id = aws_route_table.publicroute.id
}
 #routetable ass private
 resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.pri-sub.id
    route_table_id = aws_route_table.privateroute.id
   
 }

 #securitygrp 
 resource "aws_security_group" "sg-1" {
    vpc_id = aws_vpc.vpc-1.id
    name = "ssh"
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
 }


 #ec2
 resource "aws_instance" "pubec2-1" {
    ami = "ami-00f4e1d08499d41c3"
    instance_type = "t3.micro"
    key_name = "seoul"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.sg-1.id]
    tags = {
      Name="publicec2-1"
    }
 }

 resource "aws_instance" "priec2-2" {
    ami = "ami-00f4e1d08499d41c3"
    instance_type = "t3.micro"
    key_name = "seoul"
    subnet_id = aws_subnet.pri-sub.id
    vpc_security_group_ids = [aws_security_group.sg-1.id]
    tags = {
      Name="privateec2-2"
    }
 }