# PNPM with libvips
A docker image contains [PNPM](https://pnpm.io/) and [libvips](https://github.com/libvips/libvips) library to install [sharp](https://www.npmjs.com/package/sharp) package

All built images can be found here https://hub.docker.com/r/ngoctp/pnpm-with-libvips/tags

### Example commands to build and push
```bash
docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder

docker buildx build --push --platform linux/arm64,linux/amd64 --build-arg NODE_VERSION=24-slim --build-arg PNPM_VERSION=10.17.1 -t ngoctp/pnpm-with-libvips-playwright:10.17.1-node24 .
```
