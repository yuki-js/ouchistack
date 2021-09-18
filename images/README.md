# Images

Images are built with GitHub Actions.

Dockerfile.base is the base image and it has general functionality. If you don't need it, set `FROM` to `scratch`.

Dockerfile is the image that is used for the production. It has more specific functionality and configuration.