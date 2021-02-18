variable "env" {
    type = string
    description = "deployment environment"
    default = "dev"
}

variable "image" {
    type = map
    description = "container image version"
    default = {
        dev = "nodered/node-red:latest"
        prod = "nodered/node-red:latest-minimal"
    }
}
# terraform plan -var="env=prod"

variable "ext_port" {
    type = map
    # type = number
    # default = [1880]
    #  sensitive = true
      
      validation {
        condition =  max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
        error_message = "External port range must be between 0 and 65535."
    }
      validation {
        condition =  max(var.ext_port["prod"]...) < 1980  && min(var.ext_port["prod"]...) >= 1880
        error_message = "External port range must be between 0 and 65535."
    }
    
    
}

locals {
    container_count = length(lookup(var.ext_port, var.env))
}

variable "int_port" {
    type = number
    default = 1880
    
    # validation {
    #     condition =  var.int_port == 1880
    #     error_message = "Nodered internal port must be 1880."
    # }
}

# variable "container_count" {
#     type = number
#     default = 3
# }