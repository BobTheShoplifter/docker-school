# Docker-School

Docker can be used for alot of stuff in the example repo i will be showing a docker based build structure. Also how you can be setting it up for a production enviroment with your website automaticly updating.

## Website
For the website files i wont be showing directly how to make it. Allthough it can be as simple as using a plain HTML file or a React/Vue/Angular based structure.

All files of your website can be put inside of the site folder.

## Example

In this example ive laid up for 2 builds 1 for master it will be tagged :latest andone for test branch that will be tagged with :test


## Deployment of Master
```sh
docker network create nginx-proxy 

docker pull jwilder/nginx-proxy:latest 

docker run -d -p 80:80 --name nginx-proxy --net nginx-proxy -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy

### IF YOUR REPO IS PRIVATE YOU NEED TO RUN 
docker login registry.gitlab.com/bobtheshoplifter/docker-school:latest
###

docker run --restart unless-stopped --name html-site --expose 80 --net nginx-proxy -e VIRTUAL_HOST=domain.site.com -d -p 8088:8088 registry.gitlab.com/bobtheshoplifter/docker-school:latest
```

After running these commands point the domain defined in ```VIRTUAL_HOST=domain.site.com``` to the server ip address

EX @ --> A --> 172.23.23.22
@ = Domain root
A = A record
172.23.23.22 = The server ip address

### Auto updates of the website

```sh
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock -v /var/config.json:/config.json containrrr/watchtower html-site --interval 15 --cleanup
```

html-site = name of the container set ```--name html-site```

