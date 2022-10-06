# multipass 

## install multipass 
```
brew install --cask multipass
```

## Create VM 
```
multipass launch -n docker
```

get info: 
```
multipass launch -n docker
multipass list
```

## install docker in multipass 
```
multipass shell docker

curl -sSL https://get.docker.com | sh
```

## cleanup 
```
multipass delete -p docker
```