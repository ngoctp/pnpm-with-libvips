# PNPM with libvips
A docker image contains [PNPM](https://pnpm.io/) and Debian [libvips](https://github.com/libvips/libvips) with **HEIC/HEIF** support, so [sharp](https://www.npmjs.com/package/sharp) can convert iPhone photos without an external service.

Uses system `libvips-dev` plus `SHARP_FORCE_GLOBAL_LIBVIPS=1` (sharp’s prebuilt binary does not include HEIC).

All built images can be found here https://hub.docker.com/r/ngoctp/pnpm-with-libvips/tags

### Example commands to build and push

Both OrbStack and Docker Desktop’s default `docker` driver cannot push multi-platform images. Use a `docker-container` builder (or enable containerd image store on Docker Desktop).

#### OrbStack

```bash
docker buildx create --name multi-platform-builder --driver docker-container --platform linux/amd64,linux/arm64 --use
docker buildx inspect --bootstrap
```

#### Docker Desktop

1. Open **Settings → General** and enable **Use containerd for pulling and storing images**, then apply & restart  
   — or create a `docker-container` builder (same as OrbStack):

```bash
docker buildx create --name multi-platform-builder --driver docker-container --platform linux/amd64,linux/arm64 --use
docker buildx inspect --bootstrap
```

2. Ensure QEMU/binfmt is available for cross-arch builds (Docker Desktop usually ships this; if `linux/amd64` fails on Apple Silicon):

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
```

#### Build and push

```bash
docker buildx build --push --platform linux/arm64,linux/amd64 --build-arg NODE_VERSION=24-slim --build-arg PNPM_VERSION=12.3.4 -t ngoctp/pnpm-with-libvips-playwright:12.3.4-node24 -t ngoctp/pnpm-with-libvips-playwright:latest .
```

### Verify HEIC/HEIF in the image
```bash
docker run --rm ngoctp/pnpm-with-libvips-playwright:latest vips -l | grep -i heif
```
