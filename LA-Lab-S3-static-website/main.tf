#-----------------root/main.tf-----------------------
provider "aws" {
    region = "${var.aws_region}"
}
data "template_file" "policy" {
    template = "${file("policy.json")}"
    vars {
        bucket_name = "${var.bucket_name}"
    }
}
resource "aws_s3_bucket" "www" {
    bucket = "${var.bucket_name}"
    acl = "public-read"
    policy = "${data.template_file.policy.rendered}"
    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

resource "aws_s3_bucket_object" "indexpage" {
    source  = "${var.index_file}"
    key     = "index.html"
    bucket  = "${aws_s3_bucket.www.id}"
}

resource "aws_s3_bucket_object" "errorpage" {
    source  = "${var.error_file}"
    key     = "error.html"
    bucket  = "${aws_s3_bucket.www.id}"
}