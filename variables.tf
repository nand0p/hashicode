variable "bucket" {
  type    = string
  default = "hashicode.hex7.com"
}

variable "tags" {
  type      = map
  default   = {
    owner   = "hex7"
    product = "hashicode"
  }
}
