terraform {
  backend "remote" {
    organization = "exciting-deer-organization"

    workspaces {
      name = "exciting-deer-tfc"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_cloudwatch_log_group" "es_logs" {
  for_each = toset(["first","second"])
  name = "alpha/melbourne/${each.key}"
}

module "network" {
  source              = "git::https://github.com/ryanmiriyagalla/exciting-deer-tfc.git//modules/network?ref=tfcmodules"
  availability_zone                = "ap-southeast-2a"
  map_public_ip_on_launch          = true

}