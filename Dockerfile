ARG BASE_IMAGE=mcr.microsoft.com/vscode/devcontainers/python
ARG BASE_TAG=3.11-bullseye
FROM ${BASE_IMAGE}:${BASE_TAG}

#
# configure container environment
#
ARG USERNAME=vscode
USER root

#
# configure VS Code ephemeral volume
#
VOLUME [ "/home/${USERNAME}/.vscode-server" ]
RUN set -eux; \
  mkdir -p "/home/${USERNAME}/.vscode-server" || true ; \
  chown ${USERNAME}:${USERNAME} "/home/${USERNAME}/.vscode-server"

#
# container runtime configuration
#
USER ${USERNAME}
# WORKDIR "/home/${USERNAME}/"
