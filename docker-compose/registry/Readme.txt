# Add labels to specific nodes (change the names to match your environment)
# REF: https://medium.com/@kalahari/running-a-mongodb-replica-set-on-docker-1-12-swarm-mode-step-by-step-a5f3ba07d06e
docker node update --label-add swarm.node=1 $(docker node ls -q -f name=photon01)
docker node update --label-add swarm.node=2 $(docker node ls -q -f name=photon02)
docker node update --label-add swarm.node=3 $(docker node ls -q -f name=photon03)
# Remove labels
#docker node update --label-rm swarm.node $(docker node ls -q -f name=photon01)
#docker node update --label-rm swarm.node $(docker node ls -q -f name=photon02)
#docker node update --label-rm swarm.node $(docker node ls -q -f name=photon03)

# Use the "Visualizer" so you can see what is going on!
# REF: https://github.com/dockersamples/docker-swarm-visualizer
# Note: The placement constraint for the Visualizer MUST land on a Docker Swarm Manager to work! --constraint=node.role==manager
docker service create --name=visualizer --publish=8080:8080/tcp --constraint=node.labels.swarm.node==2 --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer

# Deploy a local private Docker registry that can be used my all members of this Docker Swarm
docker service create --name=registry --publish=5000:5000/tcp --constraint=node.labels.swarm.node==1 registry:2

