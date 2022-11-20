module "vpc" {
  source = "./modules/vpc"
}
module "subnet" {
  source = "./modules/subnet"
  vpcid = module.vpc.Vpcid
}
module "balancer" {
  source = "./modules/balancer"
  vpcid = module.vpc.Vpcid
  sgid = [module.subnet.sgid]
  websubnetid = [module.subnet.Websubnet1id,module.subnet.Websubnet2id]
}
module "db" {
  source ="./modules/db"
  vpcid = module.vpc.Vpcid
  sgid = [module.subnet.sgid]
  databasesubnetid = [module.subnet.databasesubnet1id,module.subnet.databasesubnet2id]
}
module "WAF" {
  source = "./modules/WAF"
  name          = "waf-alb"
  metric_name   = "waf-alb"
  alb-arn-var = module.balancer.alb-arn-name

}
