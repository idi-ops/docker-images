FROM fedora:32

ENV FIREFOX_VERSION 81.0

ENV CHROME_REPO_URL http://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome-stable
ENV CHROME_VERSION 85.0.4183.121-1

ENV NODE_REPO_URL https://rpm.nodesource.com/pub_12.x/fc/31/x86_64/nodejs
ENV NODE_VERSION 12.18.4

RUN dnf -y install git python make gcc Xvfb                                   \
                   firefox-${FIREFOX_VERSION}                                 \
                   ${CHROME_REPO_URL}-${CHROME_VERSION}.x86_64.rpm            \
                   ${NODE_REPO_URL}-${NODE_VERSION}-1nodesource.x86_64.rpm && \
    dnf clean all                                                          && \
    npm install -g grunt-cli nyc testem                                    && \
    npm cache clean --force

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
