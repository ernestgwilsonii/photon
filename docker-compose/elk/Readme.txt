# Elasticsearch 
# REF: https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html

# Storage on each docker host will be bind mounted
# Use Ansible:
mkdir -p /opt/elasticsearch/data
chmod -R a+rwx /opt/elasticsearch


cd /opt/photon/docker-compose/elk/

#docker stack deploy --compose-file=docker-compose.yml elk
docker stack deploy --compose-file=docker-compose-x-pack.yml elk

docker ps
docker logs -f blah

curl 'localhost:9200/_cat/nodes?v'
curl 'localhost:9200/_cat/health?v'

docker stack rm elk


