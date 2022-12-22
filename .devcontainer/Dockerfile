# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.0/containers/alpine/.devcontainer/base.Dockerfile

# [Choice] Alpine version: 3.16, 3.15, 3.14, 3.13
ARG VARIANT="3.16"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-${VARIANT}

# ** [Optional] Uncomment this section to install additional packages. **
#RUN echo $HTTP_PROXY && echo $http_proxy && unset HTTP_PROXY && unset http_proxy && apt-get update
RUN apk update
RUN apk add --no-cache sqlite
