FROM fedora:28

# Version definitions
ENV FIREFOX_VERSION 61.0
ENV CHROME_VERSION 67.0.3396.99-1
ENV NODE_BRANCH 10
ENV NODE_VERSION 10.6.0

# Install OS-level dependencies
RUN dnf -y install git python make gcc && \
    dnf -y install firefox-${FIREFOX_VERSION} && \
    dnf -y install http://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome-stable-${CHROME_VERSION}.x86_64.rpm && \
    dnf -y install https://rpm.nodesource.com/pub_${NODE_BRANCH}.x/fc/28/x86_64/nodejs-${NODE_VERSION}-1nodesource.x86_64.rpm && \
    dnf clean all

# Install npm dependencies
RUN npm install -g grunt-cli istanbul testem && npm cache clean --force

# Run shell by default
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
