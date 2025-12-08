variable "identifier" {
  description = "Identifier applied to AWS resources and tags."
  type        = string
  default     = "sa-tech-scenario-2-tf"
}

variable "instance_type" {
  description = "EC2 instance type used for the nginx host."
  type        = string
  default     = "t3.micro"
}

variable "allowed_cidr" {
  description = "CIDR allowed to reach the instance on HTTP/HTTPS/SSH."
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name to associate with the instance."
  type        = string
  default     = ""
}

variable "ami_ssm_parameter" {
  description = "SSM Parameter Store path that resolves to the desired AMI."
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

variable "vpc_cidr" {
  description = "CIDR range for the dedicated VPC."
  type        = string
  default     = "10.42.0.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet."
  type        = string
  default     = "10.42.0.0/25"
}

variable "cost_center" {
  description = "Cost center tag value."
  type        = string
  default     = "demo"
}

variable "extra_tags" {
  description = "Additional tags merged into every supported resource."
  type        = map(string)
  default     = {}
}
