FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y apt-transport -https
RUN apt-get install -y systemd
RUN apt-get install -y iputils-ping
RUN apt-get install -y nano
RUN apt-get install -y wget
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y libcurl4-openssl-dev libssl-dev 
RUN apt-get install -y libsmó libxext6 libxrender-dev
RUN apt-get install -y libgl1-mesa-glx
RUN apt-get install -y python3-pip 
RUN apt-get install -y python3-graphviz

WORKDIR /home
COPY . /home

RUN pip3 install -r requirements.txt
RUN echo 'export PYTHONPATH='..:.:../..'' >> ~/.bashrc

EXPOSE 8000

CMD ["bash", "run.sh"]
#How TO build and start container
# docker run -it -d -v /mnt/volume:/data --name SCONTAINERNAME$ $IMAGENAME$:$IMAGETA6$ bash