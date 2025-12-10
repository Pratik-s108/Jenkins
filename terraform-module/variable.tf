variable "region" {
  default = "ap-south-1"
}
variable "az_1" {
  default = "ap-south-1a"
}
variable "az_2" {
  default = "ap-south-1b"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_cidr" {
  default = "10.0.0.0/20"
}
variable "private_cidr" {
  default = "10.0.16.0/20"
}
variable "name1" {
  default = "Frontend"
}
variable "name2" {
  default = "Backend"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "ami_id" {
  default = "ami-02b8269d5e85954ef"
}