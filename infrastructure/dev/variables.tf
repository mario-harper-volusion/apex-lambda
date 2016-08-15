# pass in via ENV var 
variable "aws_account_id" {
	default = "124223853155"
}

variable "aws_region" {
	default = "us-west-2"
}

variable "stage" {
	default = "dev"
}

variable "api_stage" {
	default = "dev"
}