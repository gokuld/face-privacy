FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --upgrade \
    pip \
    pipenv

RUN groupadd streamlit-ui && useradd --no-log-init -g streamlit-ui streamlit-ui

USER streamlit-ui:streamlit-ui

WORKDIR /home/streamlit-ui

COPY ./src/ .

RUN pipenv install --deploy --ignore-pipfile

EXPOSE 80

HEALTHCHECK CMD curl --fail http://localhost:80/_stcore/health

ENTRYPOINT ["pipenv", "run", "streamlit", "run", "ui.py", "--server.port=80", "--server.address=0.0.0.0"]
