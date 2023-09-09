variable "face_blur_model_service_task_container_name" {}

provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source = "./modules/network"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.network.vpc_id
}

module "ecs_task_definition" {
  source = "./modules/ecs_task_definition"

  public_subnet_a_id                          = module.network.public_subnet_a_id
  public_subnet_b_id                          = module.network.public_subnet_b_id
  face_blur_model_service_security_group_id   = module.security_groups.face_blur_model_service_security_group_id
  face_blur_model_service_task_container_name = var.face_blur_model_service_task_container_name
}

module "ecs_service" {
  source = "./modules/ecs_service"

  public_subnet_a_id                          = module.network.public_subnet_a_id
  public_subnet_b_id                          = module.network.public_subnet_b_id
  face_blur_model_service_security_group_id   = module.security_groups.face_blur_model_service_security_group_id
  face_blur_model_service_lb_target_group_arn = module.alb.face_blur_model_service_lb_target_group_arn
  face_blur_model_service_task_arn            = module.ecs_task_definition.face_blur_model_service_task_arn
  face_blur_model_service_task_container_name = var.face_blur_model_service_task_container_name
}

module "alb" {
  source = "./modules/alb"

  vpc_id                                    = module.network.vpc_id
  public_subnet_a_id                        = module.network.public_subnet_a_id
  public_subnet_b_id                        = module.network.public_subnet_b_id
  face_blur_model_service_security_group_id = module.security_groups.face_blur_model_service_security_group_id
}

module "route53" {
  source = "./modules/route53"

  lb = module.alb.privfacy_alb
}
