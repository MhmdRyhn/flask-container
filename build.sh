#!/bin/bash

set -x
set -e

aws_profile="dev"
account_id=$(aws sts --profile $aws_profile get-caller-identity | jq -r ".Account")

# Build docker image
docker build . -t "$account_id.dkr.ecr.eu-west-1.amazonaws.com/flask-container:latest"
# Login to AWS ECR
aws ecr get-login-password --profile $aws_profile --region eu-west-1 |
  docker login --username AWS --password-stdin "$account_id.dkr.ecr.eu-west-1.amazonaws.com"
# Push the image to ECR
docker push "$account_id.dkr.ecr.eu-west-1.amazonaws.com/flask-container:latest"
