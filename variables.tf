variable "ext_port" {
    type = list
    # type = number
    # default = [1880]
    #  sensitive = true
      
      validation {
        condition =  max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
        error_message = "External port range must be between 0 and 65535."
    }
}

locals {
    container_count = length(var.ext_port)
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