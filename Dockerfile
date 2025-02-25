ARG SOURCE_IMAGE_NAME=ubi9/ubi
FROM --platform=${TARGETPLATFORM} registry.access.redhat.com/${SOURCE_IMAGE_NAME}:latest AS base

ARG IMAGE_BASE_NAME=rhel
ARG DNF=dnf

RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && source $HOME/.local/bin/env \
    # install python 3.11 with uv \
    && uv python install 3.11 \
    && uv run python -m venv $HOME/.venv
