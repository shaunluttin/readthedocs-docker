
# Run Locally

    git clone git@github.com:shaunluttin/readthedocs-docker.git
    cd readthedocs-docker
    docker build . shaunluttin/readthedocs:v0.0.0
    docker run --detach --name readthedocs --publish-all shaunluttin/readthedocs:v0.0.13
    docker port readthedocs

Open a browser and go to localhost:PORT
    
# Create a Docker Image and Push it to Docker Hub

    docker build . --tag shaunluttin/readthedocs-docker:v0.0.0 
    docker images 
    docker push shaunluttin/readthedocs-docker:v0.0.0

Create an Azure App Service with this Docker Image

    az group create --name myResourceGroupXX --location "West Europe"      
    az appservice plan create --name myAppServicePlanXX --resource-group myResourceGroupXX --sku B1 --is-linux      
    az webapp create --resource-group myResourceGroupXX --plan myAppServicePlanXX --name bigfontdockerXX --deployment-container-image-name shaunluttin/temp:v0.0.1      
    az webapp log config --resource-group myResourceGroupXX --name bigfontdockerXX --web-server-logging filesystem      
    az webapp log tail --name bigfontdockerXX --resource-group myResourceGroupXX
    az webapp deployment container config -n bigfontdockerXX -g myResourceGroupXX -e true

    # change the docker image
    az webapp config container set --resource-group myResourceGroupXX --name bigfontdockerXX -c elnably/dockerimagetest
    az webapp config container set --resource-group myResourceGroupXX --name bigfontdockerXX -c training/webapp
