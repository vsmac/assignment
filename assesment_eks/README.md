# docker compose

sudo docker-compose build (build docker images)
sudo docker-compose up (run docker-compose locally in detach mode use (-d)

# to deploy app in eks

1. create docker image and push on ECR

docker build -t nclouds:test .
docker tag ecr_registry:latest accountnumber.dkr.ecr.ap-south-1.amazonaws.com/ecr_registry:latest
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin accountnumber.dkr.ecr.ap-south-1.amazonaws.com
docker push accountnumber.dkr.ecr.ap-south-1.amazonaws.com/ecr_registry:latest

Now we can use same image in EKS

