docker build -t test .
docker run -ti --rm -p 80:80 --name=testc test