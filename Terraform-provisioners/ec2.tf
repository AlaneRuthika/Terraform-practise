resource "aws_instance" "ec2_example" {
    ami = "ami-047c07f7a17c62997"  
    instance_type = "t3.micro" 
    key_name= "seoulkey"
    vpc_security_group_ids = [aws_security_group.main.id]


  provisioner "file" {
    source      = "C:/Users/alane/Desktop/vcube/hello.txt"
    destination = "/home/ubuntu/hello.txt"
  }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/alane/Desktop/keypair/seoulkey")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "seoulkey"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFpbkFJab4RFO9PFHIpqEFtONxbZTVym0F5cnWJmPFz alane@Ruthika"
}