# pass in via ENV var 
variable "aws_account_id" {}

variable "aws_region" {
	default = "us-west-2"
}

variable "stage" {
	default = "prod"
}

variable "api_stage" {
	default = "prod"
}