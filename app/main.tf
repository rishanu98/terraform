provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
}

resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

    ingress {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH traffic"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["141.72.242.43/32"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Here we are uploading the public key to AWS and creating a key pair.
# This key pair will be used to connect to the EC2 instance.

resource "aws_key_pair" "web-app_key" {
  key_name   = "web-app_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web_server" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"
  key_name     = aws_key_pair.web-app_key.key_name
  availability_zone = "us-east-1a"
  subnet_id     = aws_subnet.subnet.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.web-server-sg.id]

  connection {
    type        = "ssh"
    user        = "ubuntu" # Replace with the appropriate username for your AMI
    private_key = file("~/.ssh/id_rsa") # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "file" {
    source = "./app.py"
    destination = "/home/ubuntu/app.py"

  }
 # Redirect stderr(2) to wherever stdout(1) is going, which is app.log in this case.
 # This way we can capture any errors that occur during the execution of the app.py
 # script in the app.log file for troubleshooting purposes.
  provisioner "remote-exec" {
    inline = [
        "echo 'Running remote commands to set up the Flask web app and start the application'",
        "sudo apt update -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3 -y",
        "sudo apt install python3.14-venv -y",
        "cd /home/ubuntu",
        "sudo apt install python3-flask -y",
        "sudo bash -c 'nohup python3 /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &'",
    ]
    }

  tags = {
    Name = "WebServer"
  }
}