

resource "random_string" "random" {
  count = local.container_count
  length  = 3
  special = false
  upper   = false
}




module "image" {
  source = "./image"
}

resource "null_resource" "dockervol" {
      provisioner "local-exec" {
        command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
      }  
  }


resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = module.image.image_out

  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
    protocol = "tcp"
    ip       = "0.0.0.0"

  }
  
  volumes {
      container_path = "/data"
      host_path = "/home/ubuntu/environment/terraform_docker/noderedvol"
  }
}

# resource "docker_container" "nodered_container2" {
#   name  = join("-",["nodered",random_string.random2.result])
#   image = docker_image.nodered.latest

#   ports {
#     internal = 1880
#   # external = 1880
#     protocol = "tcp"
#     ip       = "0.0.0.0"

#   }
# }







# resource "docker_image" "task_image" {
#   name = "si3mshady/reacttaskapp:latest"
# }

# resource "docker_container" "task_container" {
#   name  = "task_container"
#   image = docker_image.task_image.latest

#   ports {
#     internal = 80
#     external = 5000
#     protocol = "tcp"
#     ip       = "0.0.0.0"

#   }
# }



