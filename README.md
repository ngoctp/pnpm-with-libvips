# pnpm-with-libvips
A docker image contains [PNPM](https://pnpm.io/) and [libvips](https://github.com/libvips/libvips) library to install [sharp](https://www.npmjs.com/package/sharp) package

### Example commands to build and push
```bash
docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder

docker buildx build --push --platform linux/arm64,linux/amd64 --build-arg NODE_VERSION=18-slim --build-arg PNPM_VERSION=8.15.8 -t ngoctp/pnpm-with-libvips:8.15.8-node18 .
```
