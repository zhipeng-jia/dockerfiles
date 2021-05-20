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
RUN mkdir -p /home/ubuntu/.ssh
RUN cat /tmp/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
RUN chown ${USER_UID} /home/ubuntu/.ssh/authorized_keys

COPY ./setup_ubuntu.sh /tmp
RUN ORIGINAL_USER=ubuntu /tmp/setup_ubuntu.sh

RUN apt -y install nano git gdb tmux
RUN apt -y clean

RUN update-alternatives --verbose --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-10 90
RUN update-alternatives --verbose --install /usr/bin/clang-format clang-format /usr/bin/clang-format-10 90

ENV CONAN_BIN=/home/${USER_NAME}/.local/bin/conan

RUN sudo -u ${USER_NAME} ${CONAN_BIN} profile new --detect --force default
RUN sudo -u ${USER_NAME} ${CONAN_BIN} profile update settings.compiler.libcxx=libstdc++11 default

COPY ./conan-config /tmp/conan-config
RUN sudo -u ${USER_NAME} mkdir -p /tmp/conan-install
RUN sudo -u ${USER_NAME} ${CONAN_BIN} install -if /tmp/conan-install /tmp/conan-config --build=missing

RUN rm -rf /tmp/*
