FROM zjia/dev-container:focal

ARG USER_NAME=devuser

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

COPY ./setup-user-home.sh /tmp
RUN sudo -u ${USER_NAME} -H \
    JAVA_HOME="${JAVA_HOME}" \
    MAVEN_PATH="/opt/apache-maven-${MAVEN_VERSION}" \
    /tmp/setup-user-home.sh && \
    rm /tmp/setup-user-home.sh

VOLUME "/home/${USER_NAME}/.m2"
VOLUME "/home/${USER_NAME}/.gradle"
VOLUME "/home/${USER_NAME}/.config/JetBrains"
VOLUME "/home/${USER_NAME}/.cache/JetBrains"
VOLUME "/home/${USER_NAME}/.local/share/JetBrains"
