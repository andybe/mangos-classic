Example container for the classic mangos

What you need to know:

- How docker works (docker.io)
- linux commandline standards
- sql statments

1) Create the build container on ubuntu:focal

   docker build mangos/contrib/docker/ -t mangos-build

2) Build the source and create directory structur
   
   create a  build script

   echo "docker run -v$(pwd)/app:/app -v $(pwd):/work " \
        "--rm -it  --entrypoint ./mangos/contrib/docker/build.sh" > build.sh
        
   chmod +x build.sh

   For a rebuild next time we only need
   
    ./build.sh


3) if everything went fine we create our container by

   docker-compose build
