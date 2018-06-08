FROM fedora:28

ENV FIREFOX_VERSION 60.0.1
ENV CHROME_VERSION 67.0.3396.79-1
ENV NODE_BRANCH 10
ENV NODE_VERSION 10.4.0

RUN dnf -y install git python make gcc && \
    dnf -y install firefox-${FIREFOX_VERSION} && \
    dnf -y install http://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome-stable-${CHROME_VERSION}.x86_64.rpm && \
    dnf -y install https://rpm.nodesource.com/pub_${NODE_BRANCH}.x/fc/28/x86_64/nodesource-release-fc28-1.noarch.rpm && \
    dnf -y install nodejs-${NODE_VERSION} && \
    npm install -g grunt-cli istanbul testem && \
    useradd docker && \
    dnf clean all && \
    npm cache clean --force

USER docker
