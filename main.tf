module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"
  vpc_id              = module.vpc.aws_course_vpc_id
  security_vpc_id     = module.vpc.security_vpc_id
  public_subnet_id    = module.vpc.public_subnet_id
  private_subnet_id   = module.vpc.private_subnet_id
  security_subnet_id  = module.vpc.security_subnet_id
}

module "gwlb" {
  source          = "./gwlb"
  vpc_ids         = [module.vpc.aws_course_vpc_id, module.vpc.security_vpc_id]
  gwlb_subnet_id  = module.vpc.security_subnet_id
}