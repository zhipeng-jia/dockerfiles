FROM phusion/baseimage:focal-1.0.0
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Chicago

RUN apt update
RUN apt -y upgrade
RUN apt -y install bash-completion curl wget sudo openssh-server ca-certificates lsb-release

ARG USER_NAME=ubuntu
ARG USER_UID=1000

RUN useradd -b /home -m -s /bin/bash -u ${USER_UID} ${USER_NAME}
RUN usermod -p '*' ${USER_NAME}
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
EXPOSE 22

COPY ./id_rsa.pub /tmp
RUN sudo -u ${USER_NAME} mkdir -p /home/${USER_NAME}/.ssh
RUN sudo -u ${USER_NAME} touch /home/${USER_NAME}/.ssh/authorized_keys
RUN cat /tmp/id_rsa.pub >> /home/${USER_NAME}/.ssh/authorized_keys

RUN mkdir -p /usr/lib/jvm
RUN wget -qO- \
    https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz \
    | tar xzf - -C /usr/lib/jvm
RUN wget -qO- \
    https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz \
    | tar xzf - -C /opt

ENV JAVA_HOME="/usr/lib/jvm/jdk8u292-b10"
RUN echo "export JAVA_HOME=/usr/lib/jvm/jdk8u292-b10" >> /home/${USER_NAME}/.profile
RUN echo "export PATH=\$PATH:\${JAVA_HOME}/bin:/opt/apache-maven-3.8.1/bin" >> /home/${USER_NAME}/.profile

RUN apt -y install build-essential htop nano git gdb tmux python3-pip
RUN apt -y install less libxext6 libxrender1 libxtst6 libfreetype6 libxi6
RUN apt -y clean

RUN sudo -u ${USER_NAME} python3 -m pip install -U pip
RUN sudo -u ${USER_NAME} pip3 install projector-installer --user

ENV PROJECTOR_BIN="/home/${USER_NAME}/.local/bin/projector"
RUN sudo -u ${USER_NAME} ${PROJECTOR_BIN} --accept-license \
    ide autoinstall --config-name idea --port 8080 \
    --ide-name "IntelliJ IDEA Community Edition 2020.3.2"
EXPOSE 8080

RUN mkdir /etc/service/projector
RUN echo "#!/bin/sh\nexec /sbin/setuser ${USER_NAME} ${PROJECTOR_BIN} config run" >> /etc/service/projector/run
RUN chmod +x /etc/service/projector/run

RUN rm -rf /tmp/*
