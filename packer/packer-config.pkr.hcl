packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = ">= 1.1"
    }
  }
}

source "googlecompute" "custom-mi" {
  project_id          = var.project_id
  image_name          = var.image_name
  zone                = var.zone
  source_image_family = var.source_image_family
  image_family        = var.image_family
  ssh_username        = var.ssh_user
}

build {
  name = "csye6255-assignemnt-4-centos"
  sources = [
   "source.googlecompute.custom-mi"
  ]

  provisioner "file" {
    source      = "./webapp.zip"
    destination = "/tmp/webapp.zip"
  }

  provisioner "shell" {
    script = "./startapp.sh"
    environment_vars = [
      "SQL_USER=${var.sql_user}",
      "SQL_PASSWORD=${var.sql_password}"
    ]
  }

}

