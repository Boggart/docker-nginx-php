# Docker: Ubuntu, Nginx and PHP Stack

This is a basis for a LEMP stack (minus MySQL).

You can build this yourself after cloning the project (assuming you have Docker installed).

```bash
cd /path/to/repo/docker-nginx-php
docker build -t webapp . # Build a Docker image named "webapp" from this location "."

# Run the docker container
docker run -v /path/to/local/web/files:/var/www:rw -p 80:80 -d webapp
```

This will bind local port 80 to the container's port 80. This means you should be able to go to "localhost" in your browser (or the IP address of your virtual machine oh which Docker is running) and see your web application files.

* `docker run` - starts a new docker container
* `-v /path/to/local/web/files:/var/www:rw` - Bind a local directory to a directory in the container for file sharing. `rw` makes it "read-write", so the container can write to the directory.
* `-p 80:80` - Binds the local port 80 to the container's port 80, so local web requests are handled by the docker.
* `-d webapp` - Use the image tagged "webapp"
* If you use this with a mysql container then [link this container](http://docs.docker.io/en/latest/use/working_with_links_names/) with MySQL's (after running the MySQL container first) via `-link mysql:db`
