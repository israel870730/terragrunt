# terragrunt
Ejercicios de Terraform usando Terragrunt

# Export the profile 
# First export the profile.
export AWS_PROFILE=poc

# If you want also can export the region
export AWS_DEFAULT_REGION=us-east-1

# Update the .kube/config file to acces inside the cluster
aws eks update-kubeconfig --region us-west-1 --name demo --profile poc

# Si estoy dentro de un modulo especifico
terragrunt plan
terragrunt apply
terragrunt destroy

# Si quiero ejecutar varios modulos al mismo tiempo
terragrunt run-all apply
terragrunt run-all destroy