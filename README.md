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
