FROM ubuntu:noble AS build

# install basic stuff
RUN apt update && apt -y install python3 python3-pip python3-venv llvm make git

# llvm setup
WORKDIR /build
RUN apt -y install lsb-release wget software-properties-common gnupg
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 17
RUN apt -y install libc++-17-dev libc++abi-17-dev

# misc tools to install
RUN apt -y install virtualenv

# setup ubuntu user with sudo permissions
RUN apt -y install sudo
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change shell to bash
SHELL ["/bin/bash", "-c"]

# setup user with virtual environment
USER ubuntu
WORKDIR /home/ubuntu
RUN virtualenv venv
# add venv to bashrc so that it always activates on startup
RUN echo "source $HOME/venv/bin/activate" >> ~/.bashrc

# setup conan
COPY --chmod=755 ./setup_conan.sh .
RUN sh -c "./setup_conan.sh"

# entry directory should be the project
WORKDIR /home/ubuntu/project

