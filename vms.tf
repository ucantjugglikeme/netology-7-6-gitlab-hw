data "yandex_compute_image" "ubuntu_24_lts" {
  family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "gitlab_vm" {
  name        = "gitlab-1"
  hostname    = "gitlab-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 8
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_24_lts.image_id
      type     = "network-ssd"
      size     = 40
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.infra_subnet_d.id
    nat                = true
    security_group_ids = [
        yandex_vpc_security_group.public_sg.id,
        yandex_vpc_security_group.web_sg.id,
        yandex_vpc_security_group.local_sg.id
    ]
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }
}

resource "yandex_compute_instance" "gitlab_runner_vm" {
  name        = "gitlab-runner-1"
  hostname    = "gitlab-runner-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_24_lts.image_id
      type     = "network-hdd"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.infra_subnet_d.id
    nat                = true
    security_group_ids = [
        yandex_vpc_security_group.public_sg.id,
        yandex_vpc_security_group.local_sg.id
    ]
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }
}

resource "local_file" "inventory" {
  content = <<-XYZ
  [gitlab]
  ${yandex_compute_instance.gitlab_vm.network_interface.0.nat_ip_address}

  [gitlab-runners]
  ${yandex_compute_instance.gitlab_runner_vm.network_interface.0.nat_ip_address}
  XYZ
  filename = "./inventories/production/hosts.ini"
}