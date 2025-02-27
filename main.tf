resource "aws_security_group" "web_security_group" {
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.available.id
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "EFS mount target"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Cluster Access"
    from_port   = 6550
    to_port     = 6550
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Template = "Platform_Ec2"
  }
}

resource "aws_instance" "platform-vm" {
  ami             = data.aws_ami.amazon-linux.id
  key_name        = var.keypair_name
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  instance_type   = var.instance_type
  subnet_id       = data.aws_subnets.subnet-public.ids[0]
  depends_on = [aws_security_group.web_security_group]
  
  tags = merge(var.resource_tags, { "Name" = "${var.instance_name}" })

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
}

resource "aws_eip" "webip" {
  instance = aws_instance.platform-vm.id
  domain   = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.platform-vm.id
  allocation_id = aws_eip.webip.id
}

resource "aws_route53_record" "sub_domain_wildcard" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "*.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.webip.public_ip}"]
}

resource "aws_route53_record" "sub_domain" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.webip.public_ip}"]
}



output "instance_ip_addr" {
  value = aws_eip.webip.public_ip
}