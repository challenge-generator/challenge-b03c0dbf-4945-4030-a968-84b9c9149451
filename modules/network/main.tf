terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  vpc_cidr = var.vpc_cidr
  azs     = data.aws_availability_zones.available.names

  public_subnet_cidrs  = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, i)]
  private_subnet_cidrs = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, var.availability_zones_count + i)]
  database_subnet_cidrs = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, (var.availability_zones_count * 2) + i)]

  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-igw"
  })
}

resource "aws_subnet" "public" {
  count = var.availability_zones_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-subnet-${count.index + 1}"
    Type = "Public"
  })
}

resource "aws_subnet" "private" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-subnet-${count.index + 1}"
    Type = "Private"
  })
}

resource "aws_subnet" "database" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.database_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-database-subnet-${count.index + 1}"
    Type = "Database"
  })
}

resource "aws_eip" "nat" {
  count = var.availability_zones_count

  domain = "vpc"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-eip-nat-${count.index + 1}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  count = var.availability_zones_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-nat-gw-${count.index + 1}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-rt"
  })
}

resource "aws_route_table" "private" {
  count = var.availability_zones_count

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-rt-${count.index + 1}"
  })
}

resource "aws_route_table_association" "public" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "database" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-s3"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-dynamodb"
  })
}

resource "aws_vpc_endpoint" "ec2" {
  count = var.enable_private_endpoints.ec2 ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ec2"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ec2"
  })
}

resource "aws_vpc_endpoint" "ecr_api" {
  count = var.enable_private_endpoints.ecr_api ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ecr-api"
  })
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.enable_private_endpoints.ecr_dkr ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ecr-dkr"
  })
}

resource "aws_vpc_endpoint" "logs" {
  count = var.enable_private_endpoints.logs ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.logs"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-logs"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  count = var.enable_private_endpoints.ssm ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ssm"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ssm"
  })
}

resource "aws_vpc_endpoint" "secretsmanager" {
  count = var.enable_private_endpoints.secretsmanager ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-secretsmanager"
  })
}

resource "aws_vpc_endpoint" "sqs" {
  count = var.enable_private_endpoints.sqs ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.sqs"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-sqs"
  })
}

resource "aws_vpc_endpoint" "kinesis_firehose" {
  count = var.enable_private_endpoints.kinesis_firehose ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.kinesis-firehose"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-kinesis-firehose"
  })
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "${local.name_prefix}-vpce-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow HTTPS from within VPC"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound HTTPS"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-security-group"
  })
}

resource "aws_flow_log" "vpc_flow_logs" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  log_destination      = var.flow_log_destination
  log_destination_type = var.flow_log_destination_type
  traffic_type         = var.flow_log_traffic_type
  vpc_id               = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpc-flow-logs"
  })
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public[*].id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-nacl"
  })
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.main.cidr_block
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-nacl"
  })
}