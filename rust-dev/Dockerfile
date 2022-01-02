FROM zjia/dev-container:focal

ARG USER_NAME=devuser

COPY ./setup-user-home.sh /tmp
RUN sudo -u ${USER_NAME} -H \
    /tmp/setup-user-home.sh && \
    rm /tmp/setup-user-home.sh

COPY ./setup-rustup.sh /etc/my_init.d/02_setup_rustup.sh

VOLUME "/home/${USER_NAME}/.rustup"
VOLUME "/home/${USER_NAME}/.cargo"
VOLUME "/home/${USER_NAME}/.vscode-server"
