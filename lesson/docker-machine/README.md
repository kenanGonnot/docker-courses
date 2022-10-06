# Docker Machine

## Utilisation
* Création d'une VM ou utilisation d'une VM ou machine physique existante
* Installation de la plateforme Docker (client + daemon)
* Permet au client local de communiquer avec le daemon distant 
* Création de certificats pour sécuriser la communication
* En Local 
    * Virtualbox
    * VMWare
* Cloud
    * DigitalOcean
    * AWS
    * Azure
    * Google cloud
* Generique

docker-machine va créer une machine virtuelle (docker + dockerd)

## Les commandes 
```bash
docker-machine --help
```

* Gestion du cycle de vie (create, rm, start, stop, restart, kill, upgrade)
* Information sur l'hôte (ip, url, config, status, version)
* Liste des hôtes créés (ls)
* Copie de fichiers (scp)
* Lancement d'un shell(ssh)

## Création d'un docker hôte

<u>Exemple:</u> sur virtualbox
```bash
docker-machine create --driver virtualbox node1
```
Options additionnelles
```bash
docker-machine create --driver virtualbox --virtualbox-memory=2048 --virtualbox-disk-size=5000 node3
```

<br><u>Exemple:</u> Amazon EC2
```bash
docker-machine create --driver amazonec2 --amazonec2-access-key=${ACCESS_KEY_ID} --amazonec2-secret-key=${SECRET_ACCESS_KEY} node1
```

## Communication avec un hôte distant
* Client local communique avec le daemon local par défaut (via unix socket)
* Variables d'environnement pour cibler un hôte distant 
```bash
docker-machine env node1
```
* Définition des variables d'environnement
```bash
eval $(docker-machine env node1)
```
* Machine cible définie via la variable DOCKER_HOST
```bash
$ env | grep DOCKER
DOCKER_HOST=tcp://000.000.00.000:0000
DOCKER_MACHINE_NAME=node1
DOCKER_TLS_VERIFY=1
DOCKER_CERT_PATH=/Users/KENAN/.docker/machine/machines/node1
```
* Les commandes docker ciblent l'hôte distant
```bash
docker image ls 
```
* Suppression des variables pour cibler le daemon local
```bash
$ eval $(docker-machine env -u)

$ docker image ls
```

Ne pas oublier de supprimer la machine virtuelle
```
docker-machine rm node1
```

###### Todo later: Virtualbox 
https://gitlab.com/lucj/docker-exercices/-/blob/master/09.Machine/creation-local.md

VB not available on M1 :(

##### Todo later: DigitalOcean
https://gitlab.com/lucj/docker-exercices/-/blob/master/09.Machine/creation-DigitalOcean.md

check pay