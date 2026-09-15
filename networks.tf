resource "yandex_vpc_network" "infra_net" {
  name = "infra_net"
}

resource "yandex_vpc_subnet" "infra_subnet_d" {
  name           = "infra_subnet_d"
  network_id     = yandex_vpc_network.infra_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  zone           = "ru-central1-d"
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gw" {
  name = "infra-nat-gw"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-rt"
  network_id = yandex_vpc_network.infra_net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gw.id
  }
}

resource "yandex_vpc_security_group" "public_sg" {
  name        = "public-sg"
  network_id  = yandex_vpc_network.infra_net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "local_sg" {
  name        = "local-sg"
  network_id  = yandex_vpc_network.infra_net.id

  ingress {
    protocol       = "Any"
    description    = "Allow 10.0.1.0/24"
    v4_cidr_blocks = ["10.0.1.0/24"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-sg"
  network_id  = yandex_vpc_network.infra_net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow GitLab"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
}