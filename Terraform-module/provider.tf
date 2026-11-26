provider "aws" {
    region = "ap-northeast-2"
    profile="default"
  
}
module "server-1" {
    source = ".//module-1"
}
module "server-2" {
    source = ".//module-2"
  
}