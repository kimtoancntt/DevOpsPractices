variable "location" {
  type = string
  description = "Resource group location"
}

variable "name" {
    type = string
    description = "Resource group name"

    validation {
        condition = length(var.name) > 3 || substr(var.name, 0, 3) == "rg_"
        error_message = "The resource name value must be starting with \"rg-\" "
    }
}

variable "tags" {
  type = map(string)
  description = "Resource group tags"
}