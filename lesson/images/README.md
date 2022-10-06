# Images Docker

## Définition
* Template pour instancier des containers
* Contient une application et l'ensemble de ses dépendances 
* Portable sur n'importe quel environnement ou tourne Docker
* Composée d'une ou de plusieurs layers
    * chacune contient un syst de fichiers et des méta data
* Distribuée via un Registry (docker hub)



<u>Contenu d'une image</u>:
* Le code applicatif (nodejs, java ...)
* Les librairies dont le code à besoin (Dépendances, Module, ...)
* Un environnement d'exécution (Node ...)
* Les binaires et librairies système (OS, Ubuntu, Alpine ..)


Chaque composant est un layer. Ces layers sont stockées dans **/var/lib/docker**

Petit exercice sur layers : https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/container-layer.md

## Dockerfile
* Série d'instructions pour construire le système de fichier d'une image
* Flow standard 
    * spécification d'une image de base
    * ajout des dépendances
    * ajout du code applicatif
    * définition de la commande à lancer
* $ docker image build...

#### Exemple: Dockerfile 
```
FROM python:3.7.13
#FROM tensorflow/serving

COPY . .
WORKDIR .

RUN pip install -r requirements.txt
#RUN python -m spacy download en_core_web_sm

CMD [ "python", "app.py" ]

EXPOSE 5000
```

### Dockerfile: les instructions principales 

| COMMAND        | Définition                                                               |
|-------------|-----------------------------------------------------------------------------|
| FROM        | Image de base                                                               
| ENV         | Definition de variable d'environnement                                      |
| RUN         | Execution d'une commande, construction du filesystem de l'image             |
| COPY/ADD    | copie de ressources depuis la machine locale dans le filesystem de l'image  |
| EXPOSE      | Expose un port de l'application                                             |
| HEALTHCHECK | Verifie l'état de santé de l'application                                    |
| VOLUME      | Définition d'un volume pour la gestion des données                          |
| WORKDIR     | Définition du repertoire du travail                                         |
| USER        | Utilisateur auquel appartient le processus du container                     |
| ENTRYPOINT  | Définie la commande exécutée au lancement du container                      |
| CMD         | Définie la commande exécutée au lancement du container                      |


**<!> Bonne pratique <!>** 
* "USER" Ne pas lancer le processus du container en root 
* "HEALTCHECK" Vérifier l'état de santé du container (exemple: toutes les 5 secondes)

## Création d'images

Pour lancer l'image
```
docker image build [OPTIONS] PATH | URL | -
```
Des options courantes : 
* -f: spécifie le fichier à utiliser pour la construction (dockerfile par défaut)
* --tag / -t: spécifie le nom de l'image
* --label: ajout de métadonnées à l'image

Exemple:
```
docker image build -t repo/myimage:1.0
```


exercice: 
* Création image à partir container : https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/creation-from-container.md
* Création image à partir Dockerfile: https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/creation-Dockerfile-pong.md



(todo later ! https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/entrypoint_vs_cmd.md)

**Note Important**:
Il est important de garder en tête qu'une image est constituée de plusieurs layers. Chaque layer est une partie du système de fichiers de l'image finale. C'est le rôle du driver de stockage de stocker ces différentes layers et de construire la système de fichiers de chaque container lancé à partir de cette image. 

## Multi-stages build
* Découpage du build en plusieurs étapes
* cas d'usage courant 
    * 1ere etape 
        * utilisation d'une image de base contenant le tooling de build
        * création d'artéfacts
    * 2eme étape
        * utilisation d'une image pour la production
        * copie des artéfacts générés lors de la première étape 
* Plusieurs instructions FROM dans le Dockerfile 

Il permet de réduire la taille d'une image.

### Exemple Dockerfile multi-stages build
Application Java

```
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, world");
    }
}
```
Main.java
```
FROM openjdk:10 as build 
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java

FROM openjdk:10-jre-slim
COPY --from=build /usr/src/myapp/Main.class /usr/src/myapp
WORKDIR /usr/src/myapp
CMD ["java", "Main"] 
```
Dockerfile


Petit exercice: https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/multi-stage-build-GO.md

## Cache
* Chaque instruction utilise le cache créé lors du build précédent
* Création de l'image quasi immédiate

Il est préférable de mettre les instructions relatives à des fichiers qui sont souvent modifiés le plus loin possible dans le fichier, de façon à prendre en compte le cache. 

## Contexte de build
* Répertoire utilisé par le Docker daemon lors du build
* Contenu packagé dans un .tar et envoyé au daemon
* Gestion avec le fichier .dockerignore
    * rapidité du build
    * exclusion des données sensibles
    * meme chose que .gitignore

    
**<!>.dockerignore<!>** Important pour la gestion de mémoire et données sensibles

### Pull / Push
Pull
```
docker image pull [image]
```
Pour download une image depuis une registry. 

Avant push 
```
docker login
```
Push 
```
docker image push [image]
```
Pour push une image sur docker registry (docker hub)

### Save / Load
Save permet d'exporter une image sous le format .tar 
```
docker save -o alpine.tar alpine
```

Load permet de charger une image depuis un format .tar
```
docker load < alpine.tar
```

Très peu utilisé mais peut s'avérer utile


Exercice sur les commandes de bases: https://gitlab.com/lucj/docker-exercices/-/blob/master/06.Images/image-filesystem.md








