# Création du VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr}"

  tags = "${merge(var.tags, map("Name","vpc-${var.project}"))}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(var.tags, map("Name","igw-${var.project}"))}"
}

# Création des subnets public
resource "aws_subnet" "public" {
  count = "${length(var.availability_zones[var.region])}"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.cidr,8, count.index)}"
  availability_zone = "${element(var.availability_zones[var.region], count.index)}"

  map_public_ip_on_launch = false

  tags = "${merge(var.tags, map("Name","subnet-${var.subnets["public"]}-${var.project}-${replace(element(var.availability_zones[var.region], count.index), var.region, "")}",
    "Reach", "${var.subnets["public"]}"))}"
}

resource "aws_route_table" "public_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name        = "rt-${var.project}-public"
    Environment = "${var.env}"
  }
}

resource "aws_route_table_association" "public_routing_table" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_routetable.id}"

  count = "${length(var.availability_zones[var.region])}"
}

# Création des subnets private
resource "aws_subnet" "private" {
  count = "${length(var.availability_zones[var.region])}"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.cidr,8,length(var.availability_zones[var.region]) + count.index)}"
  availability_zone = "${element(var.availability_zones[var.region], count.index)}"

  map_public_ip_on_launch = false

  tags = "${merge(var.tags, map("Name","subnet-${var.subnets["private"]}-${var.project}-${replace(element(var.availability_zones[var.region], count.index), var.region, "")}",
    "Reach", "${var.subnets["private"]}"    
     ))}"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.0.id}"

  tags = "${merge(var.tags, 
      map("Name","nat-${var.project}-${replace(element(var.availability_zones[var.region], count.index), var.region, "")}"))}"
}

resource "aws_eip" "nat" {
  vpc = true

  tags = "${merge(var.tags, map("Name","eip-${var.project}"))}"
}

resource "aws_route_table" "private_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = "${merge(var.tags, map("Name","rt-${var.project}-private"))}"
}

resource "aws_route_table_association" "private_routing_table" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_routetable.id}"

  count = "${length(var.availability_zones[var.region])}"
}

# Création des subnet db
resource "aws_subnet" "db" {
  count = "${length(var.availability_zones[var.region])}"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.cidr,8,length(var.availability_zones[var.region]) * 2 + count.index)}"
  availability_zone = "${element(var.availability_zones[var.region], count.index)}"

  map_public_ip_on_launch = false

  tags = "${merge(var.tags, map("Name","subnet-${var.subnets["db"]}-${var.project}-${replace(element(var.availability_zones[var.region], count.index), var.region, "")}",
    "Reach", "${var.subnets["db"]}"    
     ))}"
}

resource "aws_route_table" "db_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(var.tags, map("Name","rt-${var.project}-db"))}"
}

resource "aws_route_table_association" "db_routing_table" {
  subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
  route_table_id = "${aws_route_table.db_routetable.id}"

  count = "${length(var.availability_zones[var.region])}"
}
