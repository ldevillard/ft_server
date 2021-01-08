docker build -t test .
docker run -ti --rm -p 443:443 -p 80:80 --name=testc test

#docker exec -ti *nomconteneurouid* bash
#docker system prune