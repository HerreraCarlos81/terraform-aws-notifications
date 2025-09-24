# Variables for AWS Pushover Clone

variable "service_name" {
  description = "Name of the service (used for resource naming)"
  type        = string
  default     = "pushover-clone"
  validation {
    condition     = length(var.service_name) > 0 && length(var.service_name) <= 20
    error_message = "Service name must be between 1 and 20 characters."
  }
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "custom_domain" {
  description = "Custom domain name for the service (optional)"
  type        = string
  default     = ""
}

variable "ssl_certificate_arn" {
  description = "ACM certificate ARN for custom domain (required if custom_domain is set)"
  type        = string
  default     = ""
}

variable "sender_email" {
  description = "Email address for sending notifications (must be verified in SES)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.sender_email))
    error_message = "Please provide a valid email address."
  }
}

variable "notification_email_domain" {
  description = "Domain for email notifications (optional, for custom domain)"
  type        = string
  default     = ""
}

variable "enable_email" {
  description = "Enable email notifications"
  type        = bool
  default     = true
}

variable "enable_sms" {
  description = "Enable SMS notifications"
  type        = bool
  default     = false
}

variable "enable_push" {
  description = "Enable push notifications (mobile app)"
  type        = bool
  default     = false
}

variable "message_retention_days" {
  description = "Number of days to retain messages in DynamoDB"
  type        = number
  default     = 30
  validation {
    condition     = var.message_retention_days > 0 && var.message_retention_days <= 365
    error_message = "Message retention must be between 1 and 365 days."
  }
}

variable "rate_limit_per_user" {
  description = "Maximum messages per user per hour"
  type        = number
  default     = 100
  validation {
    condition     = var.rate_limit_per_user > 0 && var.rate_limit_per_user <= 1000
    error_message = "Rate limit must be between 1 and 1000 messages per hour."
  }
}

variable "enable_api_logging" {
  description = "Enable API Gateway logging"
  type        = bool
  default     = true
}
