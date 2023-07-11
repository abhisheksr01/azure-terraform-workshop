#! /bin/bash
export PUBLIC_IP=20.117.82.231
apt update && apt install sshpass -y && mkdir ~/.ssh/ && touch ~/.ssh/known_hosts && ssh-keyscan $PUBLIC_IP >> ~/.ssh/known_hosts
sshpass -p Password1234 ssh hukadmin@$PUBLIC_IP

az vm image list --all --publisher Canonical | \
    jq '[.[] | select(.sku=="22_04-lts")]| max_by(.version)'


export PUBLIC_IP=20.117.82.231
ssh-keyscan $PUBLIC_IP >> ~/.ssh/known_hosts
sshpass -p Password1234 ssh hukadmin@$PUBLIC_IP


sudo apt update && sudo apt install python3.9 -y
alias python='/usr/bin/python3.9'
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/hukadmin/.local/bin:$PATH"
git clone https://github.com/abhisheksr01/zero-2-hero-python-flask-microservice.git
make activate


sudo python app1c.py >> log.txt 2>&1 &

# export SSHPASS='Password1234!'
# sshpass -e ssh hukadmin@20.58.51.46
# plink hukadmin@20.90.87.183 -pw Password1234!

# apt update && apt install sshpass -y && mkdir ~/.ssh/ && touch ~/.ssh/known_hosts && ssh-keyscan 20.58.51.46 >> ~/.ssh/known_hosts
# sshpass -p Password1234! ssh hukadmin@20.58.51.46
# mkdir ~/.ssh/ && touch ~/.ssh/known_hosts
# ssh-keyscan 20.90.87.183 >> ~/.ssh/known_hosts


# curl -sSL https://install.python-poetry.org | python3 -

apt update && apt install pip -y
git clone https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart
cd msdocs-python-flask-webapp-quickstart
pip install -r requirements.txt
flask run