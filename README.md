
# Prerequisites

* Windows 10
* Windows Subsystem for Linux
* Docker 
    * Tray Icon | Right Click | Settings | Expose daemon on tcp://localhost:2375 without TLS.
    * Tray Icon | Right Click | Switch to Linux Containers.

# Run Locally

We tested the following with `bash` from the Windows Subsystem for Linux.

Replace `v0.0.0` with the next appropriate version.

    git clone git@github.com:shaunluttin/readthedocs-docker.git --recurse-submodules
    cd readthedocs-docker
    docker build . --tag shaunluttin/readthedocs:v0.0.0
    docker run --detach --name readthedocs --publish-all shaunluttin/readthedocs:v0.0.0
    docker port readthedocs

The final command will output `5000/tcp -> 0.0.0.0:PORT`. Open a web browser in Windows and go to localhost:PORT.
    
# Create a Docker Image and Push it to Docker Hub

    docker build . --tag shaunluttin/readthedocs:v0.0.0 
    docker images 
    docker push shaunluttin/readthedocs:v0.0.0

# Create an Azure App Service with this Docker Image

These commands use the Azure Command Line Interface

    az group create --name myResourceGroupXX --location "West Europe"; 
    az appservice plan create --name myAppServicePlanXX --resource-group myResourceGroupXX --sku B1 --is-linux; 
    az webapp create --resource-group myResourceGroupXX --plan myAppServicePlanXX --name bigfontdockerXX --deployment-container-image-name shaunluttin/readthedocs:v0.0.0; 
    az webapp log config --resource-group myResourceGroupXX --name bigfontdockerXX --web-server-logging filesystem; 
    az webapp log tail --name bigfontdockerXX --resource-group myResourceGroupXX; 

    # enable docker continuous deployment (with updates to same image name:tag)
    az webapp deployment container config -n bigfontdockerXX -g myResourceGroupXX -e true;

    # (testing) change the docker image
    az webapp config container set --resource-group myResourceGroupXX --name bigfontdockerXX -c elnably/dockerimagetest
    az webapp config container set --resource-group myResourceGroupXX --name bigfontdockerXX -c training/webapp
    az webapp config container set --resource-group myResourceGroupXX --name bigfontdockerXX -c carinamarina/hello-world-app

    # restart after changing the image
    az webapp restart --resource-group myResourceGroupXX --name bigfontdockerXX

# Once it is Running: Configuration

https://bigfontdocker05.scm.azurewebsites.net/webssh/host

$ ./manage.py createsuperuser

# Useful Docker Commands 

docker stop $(docker ps -a -q)     
docker rm $(docker ps -a -q)

# Read the Docs Custom Install Documentation

https://docs.readthedocs.io/en/latest/custom_installs/local_rtd_vm.html#local-rtd-setup

# TODO 

1. Figure out how to host this more inexpensively that an Azure Linux App Service
2. Set up the Elastic Search.
3. Import existing documentation.

