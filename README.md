# Docker-School

Docker can be used for alot of stuff in the example repo i will be showing a docker based build structure. Also how you can be setting it up for a production enviroment with your website automaticly updating.

## Website
For the website files i wont be showing directly how to make it. Allthough it can be as simple as using a plain HTML file or a React/Vue/Angular based structure.

All files of your website can be put inside of the site folder.

## Example

In this example ive laid up for 2 builds 1 for master it will be tagged :latest andone for test branch that will be tagged with :test

the two branches are depoyed here:

[master](https://apz.websecured.io/)
[test](https://apa.websecured.io/)


## Deployment of Master
```sh
docker network create nginx-proxy 

docker pull jwilder/nginx-proxy:latest 

docker run -d -p 80:80 --name nginx-proxy --net nginx-proxy -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy

### IF YOUR REPO IS PRIVATE YOU NEED TO RUN 
docker login registry.gitlab.com/bobtheshoplifter/docker-school:latest
###

docker run --restart unless-stopped --name html-site --expose 80 --net nginx-proxy -e VIRTUAL_HOST=site.com -d -p 8080:8080 registry.gitlab.com/bobtheshoplifter/docker-school:latest
```

After running these commands point the domain defined in ```VIRTUAL_HOST=site.com``` to the server ip address

EX @ --> A --> 172.23.23.22
@ = Domain root
A = A record
172.23.23.22 = The server ip address

## Deployment of Test

With docker you can publish multiple websites on the same server with the nginx-proxy we added.

You will see in this repo there is a branch named test you can look at.

You will also need to name a branch test it is defined in the .gitlab-ci.yml that : 
```yml
  only:
    - test
```

This means that only the test brach will build with the settings defined these settings can be set pretty complex and you can do a lot via this file.
Me personaly like using the Dockerfile to do the build stuff.

Branches can also be used before submitting a Merge request and via the gitlab CI it will wait untill the build is successfull on the test branch before merging to Master.

```sh
### IF YOUR REPO IS PRIVATE YOU NEED TO RUN 
docker login registry.gitlab.com/bobtheshoplifter/docker-school:test
###

docker run --restart unless-stopped --name html-site-test --expose 80 --net nginx-proxy -e VIRTUAL_HOST=test.site.com -d -p 8081:8081 registry.gitlab.com/bobtheshoplifter/docker-school:test
```

After running these commands point the domain defined in ```VIRTUAL_HOST=test.site.com``` to the server ip address

EX test --> A --> 172.23.23.22
test = Domain subdomain
A = A record
172.23.23.22 = The server ip address

### Auto updates of the website

For this we will use [watchtower](https://github.com/containrrr/watchtower)

```sh
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock -v /var/config.json:/config.json containrrr/watchtower html-site --interval 15 --cleanup
```

html-site = name of the container set ```--name html-site``` if you have multiple sites just add one after the space ex: ```html-site html-site-test```.

