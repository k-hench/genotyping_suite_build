FROM docker.io/debian:11.3
LABEL authors="Kosmas Hench" \
      description="Container containing genotyping software"

# setting up conda
RUN apt update && apt install -y wget procps
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p /miniconda

ENV PATH ${PATH}:/miniconda/bin

# install mamba for fast installation and set up channels
RUN conda install mamba -y -n base -c conda-forge
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge

# install packages available via conda
COPY env.yml /
RUN mamba env create -f /env.yml && conda clean -a

# install est-sfs manually
RUN apt install -y git gcc make libz-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libgsl-dev
RUN mkdir -p /manual_install/bin && \
    cd /manual_install && \
    wget https://netcologne.dl.sourceforge.net/project/est-usfs/est-sfs-release-2.04.tar.gz && \
    tar -zxvf est-sfs-release-2.04.tar.gz && \
    cd est-sfs-release-2.04 && \
    make && \
    cd ../bin && \
    ln ../est-sfs-release-2.04/est-sfs ./

ENV PATH ${PATH}:/miniconda/envs/genotyping_suite-0.4/bin:/manual_install/bin