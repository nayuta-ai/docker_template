# docker_template

1. Create Docker image
```
make build
```
2. Create Docker container
```
make start
```
3. Enter Docker container
```
make attach
```
<br/>
※ Changing FILE_NAME in Makefile enable us to building other Docker environment <br/>
e.g) FILE_NAME=python_3_10 -> FILE_NAME=gpu_pytorch
