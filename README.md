# Description:

This is a service to provide privacy in images by automatically detecting and blurring faces.

Infrastructure as code (using Terraform) brings up 4 systems:

1. The face blur / detection model as a service
This is exposed at `api.example.com:3000`
2. A Streamlit UI that allows the user to upload an image and provides a result image with faces blurred.
This is exposed at `www.example.com:80`
3. A Prometheus server that is pre-configured to scrape metrics from the model service.
This is exposed at `prometheus.example.com:9090`
4. A Grafana dashboard that connects to the Prometheus data source and has dashboard for monitoring and alerts.
This is exposed at `grafana.example.com:3000`

The face detection is handled by a pre-trained face detection model called RetinaFace.

Credits: The pre-trained model is borrowed from this repo:
`https://github.com/serengil/retinaface`

# Architecture overview:

## Services
The pre-trained model, RetinaFace, is a deep TensorFlow model. This is
built as a containerized service using BentoML.  The image is
registered on AWS ECR and deployed on ECS.

The Streamlit UI is also containerized and registered on ECR and deployed on ECS.

The Prometheus server, from the official Docker image, runs on a
single EC2 instance with an EBS storage for persistent storage of the
configuration and database.  The initial Prometheus scrape
configuration is seeded using a cloud-init script.

The Grafana server also runs from the official Docker image on ECS.

## Networking:
There is a single load balancer (to optimize on cost as this is a
relatively expensive service).  There are multiple listeners and
target groups, that use conditions based on host headers to handle
traffic to each of the four systems: the model service, UI, Prometheus
server and Grafana.

# Steps to build and deploy:

## Clone the repo and initialize the environment

``` bash
git clone git@github.com:gokuld/face-privacy.git
cd face-privacy
pipenv shell
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

## Deploy the infrastructure with Terraform

``` bash
cd terraform
terraform init && terraform apply
```

Bring down the infrastructure if not needed anymore:
``` bash
cd terraform
terraform init && terraform destroy
```

# Future tasks:
## Infra
* HTTPS endpoints
* Configuration management (say with Ansible)
* Autoscaling based on load
* MLFlow server
* Continuous deployment (CD).
* Staging and production environments with Terraform.
## Product
* Being able to take user feedback
* Option to use a set of reference faces to exclude from blurring out.
* Video processing
## Documentation:
* Add images (sample input and output images, UI screenshot) in the README.
* Add diagrams for the system architecture.
* Automatic documentation of Terraform code with `terraform-docs` as part of CI.
