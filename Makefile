PROJECT_NAME=template
IMAGE_NAME=${USER}_${PROJECT_NAME}
CONTAINER_NAME=${USER}_${PROJECT_NAME}
PORT=8889
SHM_SIZE=2g
FORCE_RM=true

build_gpu_pytorch_linux:
	docker build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -g) \
		-f gpu_pytorch/linux/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

build_gpu_pytorch:
	docker build \
		-f gpu_pytorch/others/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

build_python:
	docker build \
		-f python_3_10/others/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

build_python_linux:
	docker build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -g) \
		-f python_3_10/linux/Dockerfile \
		-t ${IMAGE_NAME} \
		--force-rm=${FORCE_RM}\
		.

restart: stop run

run_gpu_pytorch:
	docker run \
		-dit \
		--gpus all \
		-v $(PWD):/workspace \
		-p $(PORT):$(PORT) \
		--name $(CONTAINER_NAME) \
		--rm \
		--shm-size $(SHM_SIZE) \
		--platform=linux/amd64 \
		$(IMAGE_NAME)

run:
	docker run \
		-dit \
		--gpus all \
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
