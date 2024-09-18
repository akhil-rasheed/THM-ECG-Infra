FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-transport-https systemd iputils-ping nano wget git curl \
    libcurl4-openssl-dev libssl-dev libsm6 libxext6 libxrender-dev libgl1-mesa-glx \
    python3-pip python3-graphviz && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home

COPY . /home

RUN pip3 install -r requirements.txt

RUN echo 'export PYTHONPATH=../..:.:$PYTHONPATH' >> ~/.bashrc

EXPOSE 8000

CMD ["bash", "run.sh"]