PROJECT_NAME=template
FILE_NAME=python_3_10
IMAGE_NAME=${USER}_${PROJECT_NAME}
CONTAINER_NAME=${USER}_${PROJECT_NAME}
PORT=8887
SHM_SIZE=2g
FORCE_RM=true

build:
	docker build \
		-f $(FILE_NAME)/Dockerfile \
		-t $(IMAGE_NAME) \
			--no-cache \
		--force-rm=$(FORCE_RM) \
		.
restart: stop start

start:
	docker run \
		-dit \
		-v $(PWD):/workspace \
		-p $(PORT):$(PORT) \
		--name $(CONTAINER_NAME) \
		--rm \
		--shm-size $(SHM_SIZE) \
		$(IMAGE_NAME)

stop:
	docker stop $(IMAGE_NAME)

attach:
	docker exec \
		-it \
		$(CONTAINER_NAME) bash 
