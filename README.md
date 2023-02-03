# README for `genotyping_suite` <img src="logo.svg" align="right" alt="" width="120" />

Github repository for the [podman](https://podman.io/) conatiner [`genotyping_suite`](https://hub.docker.com/repository/docker/khench/genotyping_suite).
The main motivation for the creation was to bundle `bwa` and `gatk` within a single container.

## Documentation of the initial setup

Originally, the `genotyping_suite` container was build using [buildah](https://buildah.io/), from the accompanying `Containerfile`:

```sh
buildah bud -t genotyping_suite
```

To make the container publicly available, it is pushed to [dockerhub](https://hub.docker.com/r/khench/genotyping_suite) using [skopeo](https://github.com/containers/skopeo) and [podman](https://podman.io/):

```sh
skopeo login -u khench docker.io
podman push localhost/genotyping_suite docker.io/khench/genotyping_suite:v0.4
```

## Accessing the container

The bundled software can be accessed directly from [dockerhub](https://hub.docker.com/r/khench/genotyping_suite) with `podman` (or `docker`, or `singularity`):

```sh
podman run docker.io/khench/genotyping_suite:v0.4 gatk --version
```