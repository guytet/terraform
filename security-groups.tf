
resource "aws_security_group" "ssh-trusted" {
  vpc_id      = module.vpc.vpc_id
  description = "allow ssh from trusted sources"
  name        = "ssh-trusted"
  ingress {
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = var.trusted-ip
    protocol    = "tcp"
  }
  tags = {
    Name = "ssh-trusted"
  }
}


resource "aws_security_group" "web-internal" {
  description = "allow http-https-internal"
  vpc_id      = module.vpc.vpc_id
  name        = "web-internal"
  ingress {
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = [var.vpc_cidr]
    protocol    = "tcp"
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    cidr_blocks = [var.vpc_cidr]
    protocol    = "tcp"
  }
  tags = {
    Name = "web-internal"
  }
}

resource "aws_security_group" "web-trusted" {
  description = "allow http-https-from-trusted"
  vpc_id      = module.vpc.vpc_id
  name        = "web-trusted"
  ingress {
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = var.trusted-ip
    protocol    = "tcp"
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    cidr_blocks = var.trusted-ip
    protocol    = "tcp"
  }
  tags = {
    Name = "web-trusted"
  }
}


resource "aws_security_group" "outbound-access" {
  description = "allow access from VPC outbound"
  vpc_id      = module.vpc.vpc_id
  name        = "outbound-access"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "outbound-access"
  }
}

resource "aws_security_group" "icmp-public" {
  description = "allow echo request"
  vpc_id      = module.vpc.vpc_id
  name        = "icmp public"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "icmp-public"
  }
}

resource "aws_security_group" "ssh-internal" {
  description = "allow ssh-internal"
  vpc_id      = module.vpc.vpc_id
  name        = "ssh-internal"
  ingress {
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = [var.vpc_cidr]
    protocol    = "tcp"
  }
  tags = {
    Name = "ssh-internal"
  }
}


resource "aws_security_group" "ssh-public" {
  vpc_id      = module.vpc.vpc_id
  description = "allow ssh-from-world"
  name        = "ssh-public"
  ingress {
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  tags = {
    Name = "ssh-public"
  }
}

resource "aws_security_group" "ipsec-IKE" {
  vpc_id      = module.vpc.vpc_id
  description = "allow ipsec vpn"
  name        = "ipsec-IKE"
  ingress {
    from_port   = "500"
    to_port     = "500"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "udp"
    description = "IPSec IKEv2 Control Path"
  }
  ingress {
    from_port   = "4500"
    to_port     = "4500"
    cidr_blocks = ["0.0.0.0/0"]
    description = "IPSec IKEv2 Control Path"
    protocol    = "udp"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "50"
    description = "IPSec IKEv2 Data Path"
  }
  tags = {
    Name = "ipsec-IKE"
  }
}
