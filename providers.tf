terraform {
  required_version = ">=1.16.0"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.225.0"
    }
  }
}

provider yandex {
  # cloud_id, folder_id and token are not specified, since
  # environment variables YC_CLOUD_ID, YC_FOLDER_ID, YC_TOKEN are provided
  zone = "ru-central1-d"
}