output "website_endpoint" {
  value = "${aws_s3_bucket.www.website_endpoint}"
}
output "bucket_id" {
  value = "${aws_s3_bucket.www.id}"
}

