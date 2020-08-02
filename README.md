# Flask Container
Docker container that contains a flask application that is served using Apache 2 WSGI server.

## Build The Image
- The image is built by running `build.sh` script. Make sure the script has executable permission.
```shell script
./build.sh
```
- In build script, the following things actually happen sequentially.
    - Image is built.
    - Login to **AWS ECR** using **AWS profile**. Note that your user need to have sufficient permission.
    - Push the built image to the AWS ECR repository. Note that the ECR repository must exist 
    and you need to have sufficient permission (to push) before pushing the image.


## Deploy The App Using The Container
- At the very beginning of deploying the app on an AWS EC2 instance, make sure Docker and AWS CLI is installed on 
your system. 
- To install the Docker you can use [this](https://github.com/MhmdRyhn/miscellaneous_docs/blob/master/docker/install.sh) 
shell script or you can follow the docker official documentation on how to install docker on your system.
- To install AWS CLI
```shell script
sudo apt-get install -y awscli
```
- Setup the AWS profile. Run `aws configure --profile dev`, it'll prompt you to enter **Access Key**, 
**Secret Access Key**, **AWS Region** and the **Output Format** (usually JSON is used). Here, the profile should be 
associated to the AWS account where the Docker image is kept in Elastic Container Registry (ECR).
- Now pull the image From ECR. Here the repository name is **flask-container** and te images tag is **latest**.
```shell script
aws ecr get-login-password --profile {dev} --region eu-west-1 | \
docker login --username AWS --password-stdin "{account-number}.dkr.ecr.{aws-region}.amazonaws.com" \
&& docker pull "{account-number}.dkr.ecr.{aws-region}.amazonaws.com/flask-container:latest"
```
In the above command, replace {account-number} and {aws-region} with an actual one.
- Run your container by executing the following command.
```shell script
docker run -d --name flask-container -p 80:80  \
{account-number}.dkr.ecr.{aws-region}.amazonaws.com/flask-container:latest
```
In the above command, replace {account-number} and {aws-region} with an actual one.
- After running the container, make sure your instance can be reached via **HTTP**, i.e., your instance is in some 
public subnet and the attached security group has HTTP inbound rule active.
