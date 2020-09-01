provider "aws" {
    profile = "mychaitanya"
    region = "ap-south-1"
}
resource "aws_db_instance" "database" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "IPL202020"
  password             = "CSKDHONI123"
  parameter_group_name = "default.mysql5.7"
  iam_database_authentication_enabled = true

tags = {
    Name  = "mysqldb"
}
}