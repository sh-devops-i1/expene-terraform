resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}
resource "aws_vpc_peering_connection" "peer" {

  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  tags = {
    Name = "${var.env}-peer"
  }
}

resource "aws_route" "main" {
  route_table_id            = aws_vpc.main.main_route_table_id                                              #var.default_rt_ID
  destination_cidr_block    = var.default_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "default" {
  route_table_id            = var.default_rt_ID
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_subnet" "frontend_main" {
  count             = length(var.frontend_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.frontend_subnets[count.index]
  availability_zone = var.Availability_zones[count.index]

  tags = {
    Name = "${var.env}-frontend-subnets-${count.index}"
  }
}

