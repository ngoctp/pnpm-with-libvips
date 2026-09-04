ARG NODE_VERSION="24-slim"

FROM node:${NODE_VERSION} AS pnpm
ARG PNPM_VERSION="12.3.4"

# System libvips includes HEIC/HEIF; sharp must use it (not its prebuilt binary)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libvips-dev chromium && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENV SHELL=/bin/bash
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=${PNPM_HOME}/bin:${PNPM_HOME}:${PATH}
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV SHARP_FORCE_GLOBAL_LIBVIPS=1

RUN npm install -g pnpm@${PNPM_VERSION}
RUN npx -y playwright@1.58.2 install --with-deps --only-shell chromium
RUN pnpm install -g @ffmpeg-installer/ffmpeg@1.1.0
RUN pnpm install -g @ffprobe-installer/ffprobe@2.1.2
