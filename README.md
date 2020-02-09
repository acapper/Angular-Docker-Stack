# BuildProcess

Development environment for live reloading angular client with nginx load balancer

## Development server

1. `docker-compose up --build`
2. https://localhost

## Production server

1. `docker-compose -f docker-compose.prod.yml up --build`
2. https://localhost

## Useful Commands

Command line for docker with <ID> `docker exec -it <ID> bash`  
Remove all containers `docker rm -f $(docker ps -a -q)`  
Remove all images `docker rmi -f $(docker images -a -q)`  
Scale web clients `docker-compose -f docker-compose.prod.yml up -d --scale client=3`  
Set image prefix `docker-compose -p <PREFIX> up`  
Export docker image `docker save -o <path for generated tar file> <image name>`  
Import docker image `docker load -i <path to image tar file>`  
