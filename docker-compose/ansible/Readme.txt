# Note: https://hub.docker.com/_/centos/

# Start the Docker Registry before you push this!

# To manually build with docker
docker build --rm -t localhost:5000/centos7-systemd-sshd-ansible:latest .

docker push

# SSH to the actual Docker host and run this container locally, it can still be pulled from the Registry!
# NOTE: Swarm mode cannot run this, so you won't see it in the visualizer
docker run --name centos7-systemd-sshd-ansible -it -d --security-opt seccomp=unconfined --stop-signal=SIGRTMIN+3 --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 2222:22 localhost:5000/centos7-systemd-sshd-ansible:latest

docker ps

ssh -p 2222 root@IP
root/root

