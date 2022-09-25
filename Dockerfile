#install image
FROM ubuntu:latest

#install package
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    vim

#install miniconda3
WORKDIR /opt
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    sh /opt/Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm -f iniconda3-py39_4.12.0-Linux-x86_64.sh

#set path
ENV PATH /opt/miniconda3/bin:$PATH

#create environment
ARG env_name=myenv
RUN conda create -yn ${env_name} python=3.9 && \
    conda init bash

#activate environment
ENV CONDA_DEFAULT_ENV ${env_name}

#switch default environment
RUN echo "conda activate ${env_name}" >> ~/.bashrc
ENV PATH /opt/conda/envs/${env_name}/bin:$PATH

#install django on ${env_name}
RUN bash -c  ". activate ${env_name}" && \
    conda install -y django

#create workspace
WORKDIR /home/workspace

WORKDIR /
