# docker-siminc2

Repo used to have a recipe(Dockerfile) to create a image used by SIMINC2

### Prerequisites
* Docker - More information [here](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1).

### Steps
* Build image
* Clone siminc2 project from [here](https://github.com/culturagovbr/siminc2)
* Create a container from image created
* Copy files 'config.inc' and 'database.php' to './includes/global'

### Folder structure to create container
```
 .. # docker-siminc2 folder
 .
 \siminc2 # cloned project
 \ZendFramework # lib dependencies
```

### How to build - New image
* Enter inside this cloned repository;
* Execute the commando below to create a new image.
```
docker build -t siminc2:1.0 .
```

This code `-t siminc2:1.0` means you will create a image named 'siminc2' and tag '1.0' and the `.` means your build will use the same folder.

You can execute the command below to create a new container using this new image created. Note: `$(pwd)` means your current directory. You can also change it, if you want.
```
docker run -it -v $(pwd):/var/www --name siminc2 -e APPLICATION_ENV="development" -p 8082:80 -p 9002:9000 culturagovbr/siminc2
```

Or You you can also execute the same command above, but arranging using docker-compose:
```
@todo fill here
```

### Extra

If you wanna check something inside your container you can access using the command below:
```
docker exec -it siminc2 bash
```

More information [here](https://hub.docker.com/r/culturagovbr/siminc2)

See the authors of this repo:
* [Authors](./Authors.md).
