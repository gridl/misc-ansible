set -e

echo "/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker" | runc exec flannel bash

cp -f /usr/lib/systemd/system/docker.service /etc/systemd/system/

sed -i s/MountFlags=slave/MountFlags=/g /etc/systemd/system/docker.service

systemctl daemon-reload

systemctl restart docker

mkdir -p /var/lib/kubelet/

chcon -R -t svirt_sandbox_file_t /var/lib/kubelet/

chcon -R -t svirt_sandbox_file_t /var/lib/docker/


Error creating default "bridge" network: Pool overlaps with other one on this address space
