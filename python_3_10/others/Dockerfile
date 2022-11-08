ARG PYTHON_VERSION=3.10

FROM python:${PYTHON_VERSION}
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
    apt-get install -y \
      curl libopencv-dev lsof git sudo tmux tree vim wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

ENV WORK_PATH /workspace
WORKDIR $WORK_PATH
ENV PYTHONPATH "/workspace:${PYTHONPATH}"
ENV PIP_OPTIONS "--no-cache-dir --progress-bar off"
COPY python_3_10/others/requirements.txt $WORK_PATH/python_3_10/others/
RUN pip install --upgrade pip && \
    pip install ${PIP_OPTIONS} -r $WORK_PATH/python_3_10/others/requirements.txt && \
    pip install ${PIP_OPTIONS} -U setuptools