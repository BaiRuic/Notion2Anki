FROM python:3.9.13-bullseye

LABEL description="Sync Notion toggle lists to Anki cards."

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ARG poetry_args='--no-dev'

# Install system dependencies
RUN apt-get update && apt-get install -y python3-pyqt5 libnss3 libasound2 \
    && rm -rf /var/lib/apt/lists/*
# Install & config poetry
RUN pip install poetry \
    && poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true

# Install project dependencies
COPY poetry.lock pyproject.toml /opt/notion2anki_addon/
WORKDIR /opt/notion2anki_addon
RUN poetry install --no-interaction --no-ansi $poetry_args

COPY . .
ENV PYTHONPATH "${PYTHONPATH}:/opt/notion2anki_addon"
