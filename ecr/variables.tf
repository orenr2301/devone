
variable "ecr_name" {

    description = "The list of ecr names to create"
    type = list(string)
    default = null
}

variable "tags" {
    description = "The key value map for tagging"
    type = map(string)
    default = {}
  
}

variable "image_mutability" {
    description = "Provide image mutability"
    type = string
    default = "MUTABLE"
}

variable "encrypt_type" {
    description = "Provider type of encryption here"
    type = string
    default = "KMS"
}

variable "s3_name" {
    description = "s3 bucket name"
    type = string
    default = null
}