FROM zjia/dev-container:focal

ARG USER_NAME=devuser

ARG GOSDK_URL
RUN wget -qO- ${GOSDK_URL} | tar xzf - -C /usr/local

COPY ./setup-user-home.sh /tmp
RUN sudo -u ${USER_NAME} -H \
    /tmp/setup-user-home.sh && \
    rm /tmp/setup-user-home.sh

VOLUME "/home/${USER_NAME}/workspace"
VOLUME "/home/${USER_NAME}/go"
VOLUME "/home/${USER_NAME}/.vscode-server"
