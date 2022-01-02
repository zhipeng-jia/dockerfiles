FROM phusion/baseimage:focal-1.0.0
CMD ["/sbin/my_init"]

ARG USER_NAME=devuser
ARG USER_UID=1000
ARG EXTRA_APT_PKGS=""

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
ENV BASIC_APT_PKGS="sudo man-db nano openssh-server apt-transport-https"

RUN apt update && \
    apt upgrade -y && \
    apt install -y ${BASIC_APT_PKGS} && \
    apt clean

RUN echo "y" | unminimize

ENV LC_ALL="en_US.UTF-8"

RUN apt install -y ${EXTRA_APT_PKGS} && \
    apt clean

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
EXPOSE 22

RUN useradd -b /home -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
    usermod -p '*' ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY ./setup-user-home.sh /tmp
RUN sudo -u ${USER_NAME} -H \
    /tmp/setup-user-home.sh && \
    rm /tmp/setup-user-home.sh

RUN echo "${USER_NAME}" > /etc/container_environment/DEVUSER

COPY ./setup-ssh-pubkey.sh /etc/my_init.d/01_setup_ssh_pubkey.sh

VOLUME "/home/${USER_NAME}/workspace"
