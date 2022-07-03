terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "my_ex_builder" {
  name         = "my_ex_builder:latest"
  keep_locally = false
}

resource "docker_container" "my_ex_builder" {
  image = docker_image.my_ex_builder.latest
  name  = "tutorial"
  ports {
    internal = 4000
    external = 4000
  }
}