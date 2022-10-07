# Network - Container Network Model 

Un container peut se connecter avec d'autre container issue du meme network. 

Networks CLI 
```
docker network --help
```

```
docker network create --drive DRIVER [OPTIONS] NAME 
```

***
* bridge 
    * auquel les containers sont attachés par défaut 
    * permet la communication des contaienrs sur un même hôte
* host
    * donne accès à la stack réseau de la machine hôte
    ```
    docker container run --network host IMAGE
    ```
     
* none
    * isolé des autres containers et de l'hôte 
    * ne configure aucune interface réseau dans le namespace du container 
* Overlay 
    * permet la communication entre containers situés sur des machines différentes 

    
***
bridge utils 
```
brctl show
```
***

Network de type overlay:
```
docker network create --opt encrypted --driver overlay mynet 
```
Attention, ne pas oublier le cryptage lors de la création du network. Par défaut, le réseau n'est pas crypté. 