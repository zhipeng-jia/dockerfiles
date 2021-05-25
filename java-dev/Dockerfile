FROM phusion/baseimage:focal-1.0.0
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Chicago

RUN apt update && \
    apt -y upgrade && \
    apt -y install bash-completion curl wget sudo openssh-server ca-certificates lsb-release

ARG USER_NAME=ubuntu
ARG USER_UID=1000

RUN useradd -b /home -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
    usermod -p '*' ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
EXPOSE 22

COPY ./id_rsa.pub /tmp
RUN sudo -u ${USER_NAME} mkdir -p /home/${USER_NAME}/.ssh && \
    sudo -u ${USER_NAME} touch /home/${USER_NAME}/.ssh/authorized_keys && \
    cat /tmp/id_rsa.pub >> /home/${USER_NAME}/.ssh/authorized_keys && \
    rm /tmp/id_rsa.pub

ARG JDK_DEB_URL
RUN apt-get install java-common && \
    wget ${JDK_DEB_URL} -P /tmp/ && \
    dpkg --install /tmp/*.deb && \
    rm /tmp/*.deb

ARG MAVEN_URL
RUN wget -qO- ${MAVEN_URL} | tar xzf - -C /opt

ARG JAVA_HOME
RUN echo "export JAVA_HOME=${JAVA_HOME}" >> /home/${USER_NAME}/.profile
RUN echo "export PATH=\$PATH:/opt/apache-maven-3.8.1/bin" >> /home/${USER_NAME}/.profile

RUN apt -y install build-essential htop nano git gdb tmux python3-pip && \
    apt -y install less libxext6 libxrender1 libxtst6 libfreetype6 libxi6 && \
    apt -y clean

RUN sudo -u ${USER_NAME} python3 -m pip install -U pip && \
    sudo -u ${USER_NAME} pip3 install projector-installer --user

ENV PROJECTOR_BIN="/home/${USER_NAME}/.local/bin/projector"
RUN sudo -u ${USER_NAME} ${PROJECTOR_BIN} --accept-license \
    ide autoinstall --config-name idea --port 8080 \
    --ide-name "IntelliJ IDEA Community Edition 2020.3.4"
EXPOSE 8080

RUN mkdir /etc/service/projector && \
    echo "#!/bin/sh\nexec /sbin/setuser ${USER_NAME} ${PROJECTOR_BIN} config run" > /etc/service/projector/run && \
    chmod +x /etc/service/projector/run

COPY ./setup-github-token.sh /opt
RUN mkdir /etc/service/github-token && \
    echo "#!/bin/sh\nexec /sbin/setuser ${USER_NAME} /opt/setup-github-token.sh" > /etc/service/github-token/run && \
    chmod +x /etc/service/github-token/run
