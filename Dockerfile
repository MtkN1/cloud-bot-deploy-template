ARG PYTHON_VERSION=3.10
ARG DEBIAN_RELEASE=bullseye

FROM python:${PYTHON_VERSION}-slim-${DEBIAN_RELEASE} AS runtime

WORKDIR /usr/src/app

COPY . .

RUN pip install --no-cache-dir .

RUN adduser -u 5678 --disabled-password --gecos "" appuser
USER appuser

ENTRYPOINT ["python", "-Bum"]
