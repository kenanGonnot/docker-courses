# Sécurité

## Exemples de menaces 
* Compromission de l'hote par un container 
    * epuisement des ressources 
    * accès au filesystem de l'hote
* Compromission d'un container par un autre container 
    * Utilisation massive des ressources 
    * problème d'un environnement multi-tenants
* Corruption de l'image utilisée 
* Compromission de l'application tournant dans un container 


## Hardening 
But: mettre en place un max de securisé afin de minimiser la surface d'attaque du systeme 

* learn.cisecurity.org/benchmarks
* Configuration de la machine hote 
* Configuration du daemon Docker 
* Fichiers de configuration du daemon Docker 
* Images et Dockerfile
* Environnement d'exécution d'un container 
* Opérations

### Docker Security Bench
* Outil basé sur les recommandations du CIS 
* Verification des bonnes pratiques pour le déploiement etc.
* github.com/docker/docker-security-bench

### Capabilités
* Controle d'accès granulaire qui améliore la dichotomie root vs non root 
* Diffétents groupe d'accès
    * CAP_CHOWN: permet la modificaiton des uid/gid
    * CAP_SYS_ADMIN: permet des opé administratives coté système
    * CAP_NET_ADMIN: permet des opé admin coté network 
    * CAP_NET_BIND_SERVICE: permet d'affecter un port privilégié (<1024) à un processus

    
Exemples: 
```
docker run -ti --cap-add=SYS_ADMIN alpine sh
```

```
docker run --cap-drop=NET_RAW alpine ping 8.8.8.8
```

## Linus Security Modules: SELinux -> à voir plus tard ! 


## Seccomp
* permet d'interdire des commandes/appels linux 
* policy.json

```
docker run -it --security-opt seccomp:policy.json alpine sh
```

## Scan de vulnérabilité 
* Analyse des images
* Recherche de CVE 
* nombreux outils 
    * Anchore Engine 
    * clair 
    * docker secuirity

    
## Docker Content Trust 