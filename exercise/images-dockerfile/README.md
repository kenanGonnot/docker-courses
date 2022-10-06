# RUN 
build image
```
docker image build -t pong 1:0
```

run container 
```
docker container run --name pong -d -p 8080:80 pong:1.0
```

Test 
```
curl localhost:8080/ping
```

Delete 
```
docker rm -f pong
```
