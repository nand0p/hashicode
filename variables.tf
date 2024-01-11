variable "aws_region" {
  description = "AWS region for all resources."
  type        = string

  # france 
  default     = "eu-west-3"

  # spain 
  #default     = "eu-south-2"
}

variable "product" {
  description = "Product Name"
  type        = string
  default     = "hashicode"
}
