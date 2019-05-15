docker build -t kspray .
echo "running container"
sleep 2
docker run --rm -ti kspray
