output "ContainerName" {
  value       = docker_container.nodered_container[*].name
  description = "The name of node red container"
}

# output "ContainerName2" {
#   value       = docker_container.nodered_container[1].name
#   description = "The name of node red container"
# }


# output "IPaddressAndPortContainer1" {
#   value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
#   description = "The name of the node red container"
# }

output "IPaddressAndPortContainer" {
  value       =  [for i in docker_container.nodered_container[*]: join(":",[i.ip_address],i.ports[*]["external"])]
  description = "The name of the node red container2"
}
