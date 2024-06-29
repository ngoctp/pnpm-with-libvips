ARG NODE_VERSION="18-slim"

FROM node:${NODE_VERSION} AS pnpm
ARG PNPM_VERSION="8.15.8"

# Install necessary dependencies for Sharp
RUN apt-get update && \
    apt-get install -y \
    libvips-dev

# Install PNPM
RUN npm install -g pnpm@${PNPM_VERSION}
