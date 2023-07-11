#!/bin/bash
set -e

sudo add-apt-repository universe && sudo apt-get update && sudo apt-get install curl git python3-pip -y
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/root/.local/bin:$PATH"
echo "cloning repo"
git clone https://github.com/abhisheksr01/zero-2-hero-python-flask-microservice.git
cd zero-2-hero-python-flask-microservice 
echo "installing dependencies"
poetry config virtualenvs.create true \
  && poetry install --no-interaction --no-ansi
pip3 install flask
echo "Starting app"
pwd
python3 run.py >> log.txt 2>&1 &