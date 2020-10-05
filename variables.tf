variable "resource_group_name" {
  description = "description"
  type        = string
}

variable "nsg_name" {
  description = "description"
  type        = string
}

variable "location" {
  description = "description"
  type        = string
  default     = "West Europe"
}

variable "security_rules" {
  description = "A list of security rules to add to the security group. Each rule should be a map of values to add. See the Readme.md file for further details."
}

variable "tags" {
  description = "description"
  type        = map(string)
}
