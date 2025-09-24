# Outputs for AWS Pushover Clone

output "website_url" {
  description = "URL of the static website"
  value       = var.custom_domain != "" ? "https://${var.custom_domain}" : "https://${aws_cloudfront_distribution.website.domain_name}"
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = "${aws_api_gateway_rest_api.api.execution_arn}"
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.users.id
}

output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  value       = aws_cognito_user_pool_client.web_client.id
}

output "sns_topic_arn" {
  description = "SNS Topic ARN for notifications"
  value       = aws_sns_topic.notifications.arn
}

output "dynamodb_users_table_name" {
  description = "DynamoDB Users table name"
  value       = aws_dynamodb_table.users.name
}

output "dynamodb_messages_table_name" {
  description = "DynamoDB Messages table name"
  value       = aws_dynamodb_table.messages.name
}

output "s3_bucket_name" {
  description = "S3 bucket name for static website"
  value       = aws_s3_bucket.website.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.website.id
}

output "deployment_instructions" {
  description = "Instructions for completing the deployment"
  value = <<-EOT
    
    Deployment completed successfully!
    
    Next steps:
    1. Visit ${var.custom_domain != "" ? "https://${var.custom_domain}" : "https://${aws_cloudfront_distribution.website.domain_name}"} to access your notification service
    2. Verify your sender email (${var.sender_email}) in SES console
    3. Create your first user account through the web interface
    4. Use the API to send your first notification
    
    API Endpoint: ${aws_api_gateway_rest_api.api.execution_arn}
    
    For API documentation, see the README.md file.
  EOT
}
