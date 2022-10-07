# Docker-compose

## Présentation
* Pour gérer plusieurs conteneurs 
* Format de fichier 
    * docker-compose.yml
    * def de l'ensemble des services d'une application

## docker-compose.yml
* Définition des composants 
    * Services
    * Volumes
    * Networks
    * Secrets (swarm)
    * Configs (swarm)
* https://docs.docker.com/compose/compose-file/

Exemple: 
```
version: '3.8'
volumes:
    data:
networks:
    frontend:
    backend:
services:
    web:
        image: org/web:2.3
        networks:
            - frontend
        ports:
            - 80:80
    api:
        image: org/api:1.2
        networks:
            - backend
            - frontend
    db:
        image: mongo:4.0
        volumes:
            - data:/data/db
        networks:
            - backend    
```

**Choses à savoir:**
* Définition du volume data qui sera utilisé par un service 
* Définition de 2 networks pour isoler les services 
* Définition des 3 services qui constituent l'application 
* Pour chaque service 
    * l'image utilisée 
    * les volumes utilisés pour la persistance des données 
    * les networks auxquels chaque service est attaché 
    * les ports exposés à l'extérieur 

#### Pour lancer docker-compose 
Se poser là ou se trouve le fichier docker-compose.yml
```
docker-compose up -d
```
Si pour un fichier docker-compose spécifique:
```
docker-compose -f [nomdufichier.yml] up -d 
```
 


##### Le binaire docker-compose

| Command       | Utilisation                                          |
|---------------|------------------------------------------------------|
| up / down     | Création / suppression d'une application             |
| start / stop  | démarrage / arrêt d'une application                  |
| build         | Build des images des services                        |
| pull          | Telechargement d'une image                           |
| logs          | Visualisation des logs de l'application              |
| scale         | Modification du nombre de container pour un service  |
| ps            | Liste les containers de l'application                |



## Exemple - Voting App 

* https://github.com/dockersamples/example-voting-app
* Utilisée pour des démos / présentations 
* 5 services 
    * Nodejs / Python / .NET 
    * Redis / Postgres
    
