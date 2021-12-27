FROM phusion/baseimage:focal-1.0.0
CMD ["/sbin/my_init"]

ARG USER_NAME=ubuntu
ARG USER_UID=1000
ARG EXTRA_APT_PKGS=""

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
ENV BASIC_APT_PKGS="sudo man-db wget nano openssh-server apt-transport-https"

RUN apt update && \
    apt upgrade -y && \
    apt install -y ${BASIC_APT_PKGS} && \
    apt clean

RUN echo "y" | unminimize

ENV LC_ALL="en_US.UTF-8"

RUN apt install -y ${EXTRA_APT_PKGS}

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
EXPOSE 22

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    -O /tmp/packages-microsoft-prod.deb && \
    dpkg -i /tmp/packages-microsoft-prod.deb && \
    rm /tmp/packages-microsoft-prod.deb

RUN apt update && \
    apt install -y msopenjdk-11 && \
    apt clean

ENV JAVA_HOME="/usr/lib/jvm/msopenjdk-11-amd64"

ARG MAVEN_URL
ARG MAVEN_VERSION
RUN wget -qO- ${MAVEN_URL} | tar xzf - -C /opt

RUN useradd -b /home -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
    usermod -p '*' ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY ./setup-user-home.sh /tmp
RUN sudo -u ${USER_NAME} -H \
    JAVA_HOME="${JAVA_HOME}" \
    MAVEN_PATH="/opt/apache-maven-${MAVEN_VERSION}" \
    /tmp/setup-user-home.sh && \
    rm /tmp/setup-user-home.sh

COPY ./setup-ssh-pubkey.sh /opt
RUN echo "#!/bin/sh\nexec /sbin/setuser ${USER_NAME} /opt/setup-ssh-pubkey.sh" > /etc/my_init.d/01-setup-ssh-pubkey.sh && \
    chmod +x /etc/my_init.d/01-setup-ssh-pubkey.sh

VOLUME "/home/${USER_NAME}/workspace"
VOLUME "/home/${USER_NAME}/.m2"
VOLUME "/home/${USER_NAME}/.gradle"
VOLUME "/home/${USER_NAME}/.config/JetBrains"
VOLUME "/home/${USER_NAME}/.cache/JetBrains"
VOLUME "/home/${USER_NAME}/.local/share/JetBrains"
