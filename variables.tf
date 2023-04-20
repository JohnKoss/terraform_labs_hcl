variable "lab_name" {
  type        = string
  description = "Used to create full paths locally and in S3."
}

variable "project_path" {
  type        = string
  description = "Full path to the root of the project (path to package json)."
}

variable "lab_path" {
  type        = string
  description = "Name of the path in S3 to place the lab folder in."
}

variable "src_path" {
  type        = string
  description = "Relative path (to the root_path) of the source files."
}

variable "dist_directory" {
  type        = string
  description = "Relative path (to the root_path) of the compiled files."
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket. Will be used in the S3 path."
}
