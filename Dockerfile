# Build args for Dev, Build and Runtime Containers
ARG PYTHON_VERSION=3.10
ARG DEBIAN_RELEASE=bullseye

# Stage: Builder
FROM python:${PYTHON_VERSION}-${DEBIAN_RELEASE} AS builder

# Install Poetry for build
RUN --mount=type=cache,target=/root/.cache \
    pip install -U pip poetry

WORKDIR /usr/src/app

# Export requirements.txt and build dependencies
RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=poetry.lock,target=poetry.lock \
    poetry export -o requirements.txt --without-hashes \
    && pip wheel -w wheels -r requirements.txt

# Build package
RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=src,target=src \
    --mount=type=bind,source=README.md,target=README.md \
    poetry build -f wheel

# Stage: Runtime
FROM python:${PYTHON_VERSION}-slim-${DEBIAN_RELEASE} AS runtime

ARG PACKAGE_NAME

WORKDIR /usr/src/app

# Install dependencies
RUN --mount=type=bind,from=builder,source=/usr/src/app/requirements.txt,target=requirements.txt \
    --mount=type=bind,from=builder,source=/usr/src/app/wheels,target=wheels \
    pip install --no-cache-dir --no-index -f wheels -r requirements.txt

# Install package
RUN --mount=type=bind,from=builder,source=/usr/src/app/dist,target=dist \
    pip install --no-cache-dir --no-index -f dist ${PACKAGE_NAME}

RUN adduser -u 5678 --disabled-password --gecos "" appuser
USER appuser

# Run module
ENTRYPOINT ["python", "-Bum"]
