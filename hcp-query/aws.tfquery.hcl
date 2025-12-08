list "aws_instance" "instances" {
  provider = aws
  config {
    filter {
      name   = "tag:Identifier"
      values = ["sa-tech-scenario-2-cf"]
    }
  }
}
