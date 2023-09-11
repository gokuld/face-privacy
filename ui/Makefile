.PHONY: docker-image

docker-image:
	docker build -t face-blur-ui .

.PHONY: create-ecr-repo
create-ecr-repo:
	aws ecr create-repository \
	--repository-name face-blur-ui \
	--image-scanning-configuration scanOnPush=true \
	--region ap-south-1

.PHONY: authenticate-to-ecr
authenticate-to-ecr:
	aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 316254964329.dkr.ecr.ap-south-1.amazonaws.com

.PHONY: tag-and-push-image
tag-and-push-image:
	docker tag face-blur-ui:latest 316254964329.dkr.ecr.ap-south-1.amazonaws.com/face-blur-ui
	docker push 316254964329.dkr.ecr.ap-south-1.amazonaws.com/face-blur-ui
