# Steps to build and deploy:

## Clone the repo

``` bash
git clone git@github.com:gokuld/face-privacy.git
```

## Build the face-blur model service docker image and register it on AWS ECR:

``` bash
cd face-blur-model-service
```

1. Build the Docker image using BentoML:

``` bash
make docker-image
```

2. Initialize the ECR repo (only for the first time, when not done already):

``` bash
make create-ecr-repo
```

3. Authenticate to AWS ECR in order to push the image in the upcoming step:

``` bash
make authenticate-to-ecr
```

4. Push the image to the ECR repository
``` bash
make tag-and-push-image
```

## Build the Streamlit UI docker image and register it on AWS ECR:

``` bash
cd face-blur-ui
```

1. Build the Docker image with the Streamlit UI:

``` bash
make docker-image
```

2. Initialize the ECR repo (only for the first time, when not done already):

``` bash
make create-ecr-repo
```

3. Authenticate to AWS ECR in order to push the image in the upcoming step:

``` bash
make authenticate-to-ecr
```

4. Push the image to the ECR repository
``` bash
make tag-and-push-image
```
