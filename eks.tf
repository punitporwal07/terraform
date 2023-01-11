module "eks-cluster" {
  source                        = "terraform-aws-modules/eks/aws"
  version                       = "17.1.0"
  cluster_name                  = "eks-serverless"
  cluster_version               = "1.21"
  subnets                       = flatten([module.vpc.outputs.public_subnets, module.vpc.outputs.private_subnets])
  cluster_delete_timeout        = "30m"
  cluster_iam_role_name         = "eks-serverless-cluster-iam-role"
  cluster_enabled_log_types     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_in_days = 7

  vpc_id = module.vpc.outputs.vpc_id

  fargate_pod_execution_role_name = "eks-serverless-pod-execution-role"
  // Fargate profiles here
}
