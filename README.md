# To run app locally use below commands

sudo docker-compose build (build docker images)


sudo docker-compose up (run docker-compose locally in detach mode use (-d)

# to deploy app in eks

# create eks cluster with Terraform


# Terraform

run terraform init


terrform plan


terraform apply

# create docker image and push on ECR

docker build -t nclouds:test .

docker tag ecr_registry:latest accountnumber.dkr.ecr.ap-south-1.amazonaws.com/ecr_registry:latest


aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin accountnumber.dkr.ecr.ap-south-1.amazonaws.com


docker push accountnumber.dkr.ecr.ap-south-1.amazonaws.com/ecr_registry:latest

# Now we can use same image in EKS deploy app via kubectl


kubectl apply -f app-deploy.yaml


kubectl apply -f app-service.yaml

kubectl apply -f redis-sts.yaml


kubectl apply -f redis-svc.yaml


