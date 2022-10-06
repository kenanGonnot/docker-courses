# Stockage

## Container et persistance des données
* Les changements sont persistés dans la layer associée au container 
* Layer en lecture / écriture superposée aux layers de l'image
* Créée et supprimée avec le container 
* Pour être découplées du cycle de vie du container, les données doivent être gérées en dehors de l'union filesystem

-> **/var/lib/docker** là ou sont stockées les volumes 

## Volume
* Répertoires / fichiers existant en dehors de l'union filesystem
* Utilisé pour découpler les données du cycle de vie d'un container 
* Crée de différentes façons 
    * instruction VOLUME dans le Dockerfile
    * options -v / --mount à la création d'un container 
    * via la commande $ docker volume create
* Cas d'usage 
    * persistance des données d'une base de données
    * persistance des logs en dehors du container 

```
docker container run -v CONTAINER_PATH IMAGE
```
Docker volume command
```
docker volume --help
```

Création d'un volume 
```
docker volume create --name db-data
```

Utilisation d'un volume existant 
```
docker container run -d --name db -v db-data:/data/db mongo:4.0
```
Le contenu du container est visible dans le volume 
```
ls /var/lib/docker/volumes/db-data/_data
```

Petit exercise sur docker volume: https://gitlab.com/lucj/docker-exercices/-/blob/master/08.Storage/volumes.md

## Les drivers de volume
* Permettent la création de volumes sur différents types de stockage
* Driver par défaut: "local"
    * stockage sur la machine hôte 
    * dans /var/lib/docker/volume/ID
* Ajout de drivers supplémentairs via l'installation de plugins
* Permet l'utilisation de solution de stockage externes
* Exemples: Ceph, AWS, GCE, Azure



todo volume avec plugin sshfs: https://gitlab.com/lucj/docker-exercices/-/blob/master/08.Storage/sshfs.md
