resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PUBLIC_KEY_PATH}")}"
}

resource "aws_security_group" "mysecgroup" {
  name = "ssh_sec_group"
  
  # allow ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "mysecgroup"
  }
}

# get latest amazon linux 2 hvm AMI
data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  instance_type   = "t2.micro"
  ami             = "${data.aws_ami.amzn2.id}"
  key_name        = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.mysecgroup.name}"]

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/my_script"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/my_script",
      "sudo /tmp/my_script",
    ]
  }

  # ssh connection for file and remote-exec provisioner instructions
  connection {
    user        = "ec2-user" # default
    private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  }

  tags {
    Name = "myec2instance"
  }
}
