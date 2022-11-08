# docker_template
## linux
1. Create Docker image
- GPU Pytorch
```
make build_gpu_pytorch_linux
```
- Python3.10
```
make build_python_linux
```
2. Create Docker container
```
make run
```
3. Enter Docker container
```
make exec
```

## others
1. Create Docker image
- GPU Pytorch
```
make build_gpu_pytorch
```
- Python3.10
```
make build_python
```
2. Create Docker container
- GPU Pytorch
```
make run_gpu_pytorch
```
- Python3.10
```
make run
```
3. Enter Docker container
```
make exec
```
