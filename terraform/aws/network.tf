resource "aws_vpc" "web_sever_vpc" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "web_sever_subnet" {
  vpc_id            = aws_vpc.web_sever_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-southeast-2a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "web_sever_gateway" {
  vpc_id = aws_vpc.web_sever_vpc.id
}

resource "aws_route_table" "web_sever_rt" {
  vpc_id = aws_vpc.web_sever_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_sever_gateway.id
  }
}

resource "aws_route_table_association" "web_sever_rt_association" {
  subnet_id      = aws_subnet.web_sever_subnet.id
  route_table_id = aws_route_table.web_sever_rt.id
}
