PROJECT_NAME=template
IMAGE_NAME=${USER}_${PROJECT_NAME}
CONTAINER_NAME=${USER}_${PROJECT_NAME}
PORT=8888
SHM_SIZE=2g
FORCE_RM=true

build_gpu_pytorch:
	docker build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -g) \
		-f gpu_pytorch/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

build_python:
	docker build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -g) \
		-f python_3_10/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

restart: stop run

run:
	docker run \
		-dit \
		-v $(PWD):/workspace \
		-p $(PORT):$(PORT) \
		--name $(CONTAINER_NAME) \
		--rm \
		--shm-size $(SHM_SIZE) \
		$(IMAGE_NAME)

exec:
	docker exec \
		-it \
		$(CONTAINER_NAME) bash 

stop:
	docker stop $(IMAGE_NAME)

run_jupyter:
	jupyter nbextension enable --py widgetsnbextension
	jupyter notebook --ip 0.0.0.0 --port ${PORT} --allow-root