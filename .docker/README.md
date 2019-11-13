# Docker Images

The wheels for this library are built on travis.

For Linux the recommended way to build distribution-independent wheels is via the [manylinux docker image](https://github.com/pypa/manylinux).
Therefore we built a custom docker image from manylinux with all dependencies installed that we can run via travis until there's official maxOS support from Docker.

Future plans are to extend this also with a docker image for windows.
For macOS we will have to install the dependencies into travis every time.

## Docker Hub Tags

Since this might get extended to a second windows image, we should not have a single `latest` tag for the image.
Instead we will prefix tags with `win-` or `linux-`, so e.g.
- `win-1.0`
- `win-latest`
- `linux-1.0`
- `linux-latest`

This is inspired by other Docker Hub repositories that contain different build-types.

## Build and Push Images

As the dependencies won't change very often we will manually build the image for now, instead of using continuous integration.
This way we can just keep the Dockerfile in the code repository without the need for an additional repo.

Build the image with:
```sh
docker build -t pupillabs/pupil-detectors:linux-<TAG> - < .docker/manylinux.Dockerfile
```

Deploy the image to Docker Hub:
```sh
docker login
docker push pupillabs/pupil-detectors:linux-<TAG>
```
