FROM ubuntu:xenial-20161213

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq
RUN apt-get install -y \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    dialog \
    python \
    daemon \
    vim \
    jq \
    linux-image-4.13.0-39-generic
    
# remove unwanted systemd services
RUN for i in /lib/systemd/system/sysinit.target.wants/*; do [ "${i##*/}" = "systemd-tmpfiles-setup.service" ] || rm -f "$i"; done; \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;
  
# install docker (after removing unwanted systemd)
RUN apt-get install -y \
    docker.io

RUN echo "Add Kubernetes repo..."
RUN sh -c 'curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -'
RUN sh -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'

RUN echo "Installing Kubernetes requirements..."
RUN apt-get update -y && apt-get install -y \
  kubelet \
  kubernetes-cni \
  kubectl
  
RUN echo "Installing Kubeadm - this will fail at post-install but that doesn't matter"
RUN apt-get install -y \
  kubeadm; exit 0
  
# Create volume for docker
VOLUME /var/lib/docker
