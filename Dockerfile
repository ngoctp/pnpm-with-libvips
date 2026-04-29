ARG NODE_VERSION="24-slim"

FROM node:${NODE_VERSION} AS pnpm
ARG PNPM_VERSION="10.17.1"

# Install necessary dependencies for Sharp
RUN apt-get update && \
    apt-get install -y \
    libvips-dev chromium && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENV SHELL=/bin/bash
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=${PNPM_HOME}:${PATH}
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install PNPM
RUN npm install -g pnpm@${PNPM_VERSION}
RUN npx -y playwright@1.58.2 install --with-deps --only-shell chromium
RUN pnpm setup
RUN pnpm install -g @ffmpeg-installer/ffmpeg@1.1.0
RUN pnpm install -g @ffprobe-installer/ffprobe@2.1.2
