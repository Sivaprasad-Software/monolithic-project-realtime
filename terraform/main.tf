resource "aws_instance" "my-vm" {
ami = "ami-0055e70f580e9ae80"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.siva-sg.id]
tags = {
Name = "my-project-instance"
Environment = "PROD"
}
key_name = "london"
}

