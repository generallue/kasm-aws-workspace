data "aws_ami" "kasm" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "kasm" {
  ami                   = data.aws_ami.kasm.id
  instance_type         = "t3a.medium"
  key_name              = "your_keypair"
  subnet_id             = aws_subnet.kasm-public-1.id
  vpc_security_group_ids = [aws_security_group.kasm_sg.id]
  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
    volume_size = 22
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo dd if=/dev/zero of=/swapfile bs=1G count=4
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
  EOF
  
  tags = {
    Name = "Kasm"
  }
  depends_on = [ aws_vpc.kasm_vpc ]
}

resource "aws_eip_association" "kasm_eip_assoc" {
  instance_id   = aws_instance.kasm.id
  allocation_id = aws_eip.kasm_eip.id
}
