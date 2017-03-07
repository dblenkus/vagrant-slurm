# required by munge
chmod g-w /var/log

apt-get update
apt-get install -y slurm-llnl htop vim

mv slurm.conf /etc/slurm-llnl/
mv munge.key /etc/munge
chown munge: /etc/munge/munge.key
chmod 400 /etc/munge/munge.key

systemctl restart munge.service

echo "10.10.10.3    controller" >> /etc/hosts
echo "10.10.10.4    worker1" >> /etc/hosts
echo "10.10.10.5    worker2" >> /etc/hosts
