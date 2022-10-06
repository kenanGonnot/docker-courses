# Containers Docker 

## Sommaire 
* Creation d'un conteneur 
* Mode interactif 
* Foreground vs background 
* Publication d’un port 
* Bind-mount
* Limitation des ressources 
* Container en mode privilégié
* Les droits d’un container 
* Des options utiles 
* Les commandes de base
* Des alias utiles 

## Creation d'un conteneur 

```
docker container run -ti ubuntu bash
```

```
docker container run -d nginx:1.14-alpine
```

'-d' pour mettre en tache de fond 
'-p' pour gérer le port 

## Bind-mount
```
docker container run -v HOST_PATH:CONTAINER_PATH...
docker container run --mount type=bind,src=HOST_PATH,dst=CONTAINER_PATH...
```

cas d'usage: 
* en dev: montage du code source dans un container 
* donner accès à la socket unix du daemon docker dans un container 

###### Exemple: Creation d'un container depuis un autre container 

```
#lancement d'un container avec bind mount de la socket 
$ docker container run --name admin -ti -v /var/run/docker.sock:/var/run/docker.sock alpine 

# creation d'un container depuis le container admin 
/ # curl -XPOST --unix-socket /var/run/docker.sock -d '{"Image":"nginx:1.12.2"}' -H 'Content-type: application/json' http://localhost/containers/create

#Lancement du container depuis le container admin 
/ # curl XPOST --unix-socket /var/run/docker.sock http://localhost/containers/.../start
```

#### Exemple: Gestion d'un hôte Docker depuis un container avec Portainer 
```
docker container run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```
portainer a besoin de la socket pour avoir accès à l'api du daemon docker 

(info pour moi -> portainer comme docker desktop c'est pas mal )

#### Exemple: suppression d'un fichier sur la machine hôte 
```
#lancement d'un container avec bind mount du systeme de fichier 

#Mauvaise methode :
$ docker run -v /:/host -ti alpine
/ # rm /host/bin/sh
/ # exit
$ sh 
->bash: sh: command not found

# Bonne methode : 
#bind mount avec le flag ro (read-only)
$ docker run -ti -v /:/host:ro alpine 
/ # rm /host/bin/sh
->mv: can't rename 'sh': Read-only file system
```

## Limitation des ressources 
* Pas de limite par défaut: RAM, CPU, I/O
* Nécessaire d'imposer des limites pour ne pas impacter les autres processus


```
# Limite de consommation de la RAM
$ docker container run --memory 32m estesp/hogit    

# Différentes valeurs de l'option --cpus sur un processeur 4-core

#utilisation des 4 cores => 100% du cpu
$ docker run -it --rm progrium/stress --cpu 4

#Utilisation de 50% d'un core => ~ 12% du cpu 
$ docker run --cpu 0.5 -it --rm progrium/stress --cpu 4

#Utilisation de 2 cores => 50% du cpu 
$ docker run --cpus 2 -it --rm progrium/stress --cpu 4
```

## Les droits d'un container
* Par défaut: utilisateur root 
* root dans le container <=> root sur la machine hôte
* Bonne pratique: utiliser un user non root pour lancer un container 
    * définition de l'user à la création de l'image
    * utilisatio de l'option --user au lancement 
    * changement de l'user dans le processus du container (gosu)
* Généralement fait dans les images officiels du Docker Hub 

Verification du owner du processus: 
```bash
docker container run -d mongo:4.0

ps aux | grep mongo
```

## Des options utiles

```bash
# Specification du nom 
docker container run -d --name debug alpine:3.7 sleep 10000

#Suppression du container quand il est stoppé 
$ docker container run --rm --name debug alpine:3.7 sleep 10000

# Redémarrage automatique
$ docker container run --name api --restart=on-failure ken/api
```


Les commandes de base
| run     | Création d'un container  |
|---------|--------------------------|
| ls      | Liste des containers     |
| inspect | Détails d'un container   |
| logs    | Visualisation des logs   |
| exec    | Lancement d'un processus |
| stop    | Arrêt d'un container     |
| rm      | Suppression              |


Exercice : https://gitlab.com/lucj/docker-exercices/-/blob/master/05.Containers/base-commands.md

# Une commande utile 
```
docker run -it -privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```




