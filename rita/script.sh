sudo apt-get update
sudo apt-get install -y libsasl2-dev python-dev-is-python3 libldap2-dev libssl-dev libcairo2-dev pkg-config python3-dev
python3 -m pip install --upgrade pip
# pip install redis racksdb requests_toolbelt markdown


cd /home/kasm-user
git clone https://github.com/rackslab/Slurm-web.git

cd /home/kasm-user/Slurm-web
pip install -e ".[dev,agent,gateway,tests]"

echo "export PATH=$PATH:/home/kasm-user/.local/bin" >> ~/.bashrc
source ~/.bashrc

cd /home/kasm-user/Slurm-web/frontend
npm audit fix && npm ci

sudo mkdir /usr/share/slurm-web /usr/share/slurm-web/conf
sudo mkdir /etc/slurm-web

sudo cp /home/kasm-user/Slurm-web/conf/vendor/agent.yml /usr/share/slurm-web/conf/agent.yml
sudo cp /home/kasm-user/Slurm-web/conf/vendor/agent.ini /etc/slurm-web/agent.ini

sudo cp /home/kasm-user/Slurm-web/conf/vendor/policy.yml /usr/share/slurm-web/conf/policy.yml
sudo cp /home/kasm-user/Slurm-web/conf/vendor/policy.ini /etc/slurm-web/policy.ini

sudo cp /home/kasm-user/Slurm-web/conf/vendor/gateway.yml /usr/share/slurm-web/conf/gateway.yml
sudo cp /home/kasm-user/Slurm-web/conf/vendor/gateway.ini /etc/slurm-web/gateway.ini

dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 > /home/kasm-user/Slurm-web/conf/vendor/jwt.key
dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 > /home/kasm-user/Slurm-web/conf/vendor/slurmrestd.key
sudo mkdir /var/lib/slurm-web
sudo cp /home/kasm-user/Slurm-web/conf/vendor/jwt.key /var/lib/slurm-web/jwt.key
sudo cp /home/kasm-user/Slurm-web/conf/vendor/slurmrestd.key /var/lib/slurm-web/slurmrestd.key

# Execute Slurm-web agent
slurm-web-agent

slurm-web-gateway

cd frontend && npm run dev