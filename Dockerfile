FROM ubuntu:latest

ARG CPU_ARCHITECTURE=x64
ARG QT_INSTALLER_URL=http://download.qt.io/official_releases/online_installers/qt-unified-linux-${CPU_ARCHITECTURE}-online.run
ARG QT_INSTALLER=qt.run

ARG DISPLAY=:0
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        cmake \
        curl \
        gdb \
        git \
        libgl1-mesa-dev \
        libpulse-dev \
        libxkbcommon-x11-0 \
        rxvt-unicode \
        ssh-client \
    && rm -rf /var/lib/apt/lists/

RUN curl --location --output ${QT_INSTALLER} ${QT_INSTALLER_URL} \
    && chmod -u+x ${QT_INSTALLER} \
    && ./${QT_INSTALLER} \
    && rm -rf ./${QT_INSTALLER}

ENTRYPOINT /opt/Qt/Tools/QtCreator/bin/qtcreator.sh
