sudo apt-get update
sudo apt-get install -y libsasl2-dev python-dev-is-python3 libldap2-dev libssl-dev
sudo apt-get install -y libcairo2-dev pkg-config python3-dev
python3 -m pip install --upgrade pip
pip install redis racksdb requests_toolbelt markdown


cd /home/kasm-user
git clone https://github.com/rackslab/Slurm-web.git

cd /home/kasm-user/Slurm-web
pip install -e .

echo "export PATH=$PATH:/home/kasm-user/.local/bin" >> ~/.bashrc
source ~/.bashrc

cd /home/kasm-user/Slurm-web/frontend
npm audit fix && npm ci

sudo mkdir /usr/share/slurm-web /usr/share/slurm-web/conf
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/agent.yml /usr/share/slurm-web/conf/agent.yml

sudo mkdir /etc/slurm-web
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/agent.ini /etc/slurm-web/agent.ini

# ssh-keygen -t rsa -q -b 4096 -m PEM -f /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/jwt.key -N ""
sudo mkdir /var/lib/slurm-web
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/jwt.key /var/lib/slurm-web/jwt.key
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/slurmrestd.key /var/lib/slurm-web/slurmrestd.key

sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/policy.yml /usr/share/slurm-web/conf/policy.yml
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/policy.ini /etc/slurm-web/policy.ini

sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/gateway.yml /usr/share/slurm-web/conf/gateway.yml
sudo cp /home/kasm-user/Personal_Data/Slurm-web/conf/vendor/gateway.ini /etc/slurm-web/gateway.ini