FROM python:3.6-stretch

# needed for Pillow / PIL
RUN apt-get update
RUN apt-get -y install \
    build-essential \
    libjpeg-dev \
    zlib1g-dev \
    libtiff-dev \
    libpoppler-cpp-dev \
    pkg-config \
    python-dev \
    libmagickwand-dev \
    ghostscript \
    tesseract-ocr \
    tesseract-ocr-deu

ENV LIBRARY_PATH=/lib:/usr/lib
ENV PIPENV_VENV_IN_PROJECT=true
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN set -ex && mkdir /app
# workaround for pipenv bug: https://github.com/pypa/pipenv/issues/1328
WORKDIR /app

COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock

RUN pip3 install pipenv
RUN set -ex && pipenv install --deploy --system

USER nobody

ENTRYPOINT watchmedo auto-restart -R -d service -d config -d workers -p="*.py;*.yml" -- celery -A workers.convert.tasks -Q convert worker --loglevel=info
