resource "null_resource" "build" {
  triggers = {
    sha1a = sha1(join("", [for f in fileset("${var.project_path}/${var.src_path}", "**") : filesha1("${var.project_path}/${var.src_path}/${f}")]))
    sha1b = sha1(join("", [for f in fileset("${var.project_path}/${var.src_path}", "**") : filesha1("${var.project_path}/${var.src_path}/${f}")]))
  }

  provisioner "local-exec" {
    command     = "npm run build"
    working_dir = var.project_path
  }

  provisioner "local-exec" {
    command     = "aws s3 sync ${var.project_path}/${var.dist_directory} s3://${var.bucket_name}/${var.lab_path}/${var.lab_name}/html"
    working_dir = path.module
  }
}

// Upload the HCL config file too.
resource "aws_s3_object" "hcl" {
  bucket = var.bucket_name
  key    = "${var.lab_path}/${var.lab_name}/hcl/config.hcl"
  source = "${var.project_path}/hcl/config.hcl"
  etag   = filemd5("${var.project_path}/hcl/config.hcl")
}
