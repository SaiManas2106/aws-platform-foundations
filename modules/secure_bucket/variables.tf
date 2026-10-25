variable "bucket_name" {
  description = "Globally unique S3 bucket name."
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be 3-63 lowercase letters, digits, dots, or hyphens and start/end with a letter or digit."
  }
}

variable "tags" {
  description = "Tags applied to the bucket."
  type        = map(string)
  default     = {}
}
