variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  nullable    = false
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The provided VPC CIDR is invalid."
  }
}

variable "public_subnets" {
  description = "Public subnets configuration"
  type = object({
    cidrs = list(string)
    tags  = optional(map(string))
  })

  validation {
    condition     = alltrue([for cidr in var.public_subnets.cidrs : can(cidrnetmask(cidr))])
    error_message = "The provided network CIDRs are invalid."
  }
}

variable "private_subnets" {
  description = "Private subnets configuration"
  type = object({
    cidrs = list(string)
    tags  = optional(map(string))
  })

  validation {
    condition     = alltrue([for cidr in var.private_subnets.cidrs : can(cidrnetmask(cidr))])
    error_message = "The provided network CIDRs are invalid."
  }
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == length(var.public_subnets.cidrs)
    error_message = "The availability zones count doesn't match the subnets count."
  }

  validation {
    condition     = alltrue([for availability_zone in var.availability_zones : can(regex("^[a-z]{2}-[a-z]+-[0-9]+[a-z]$", availability_zone))])
    error_message = "Provided availability zones are invalid."
  }
}
