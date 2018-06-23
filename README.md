Create a Docker Image and Push it to Docker Hub

    docker build --tag shaunluttin/temp:v0.0.1 . 
    docker images 
    docker push shaunluttin/temp:v.0.0.1

Create an Azure App Service with this Docker Image

    az group create --name myResourceGroupXX --location "West Europe"      
    az appservice plan create --name myAppServicePlanXX --resource-group myResourceGroupXX --sku B1 --is-linux      
    az webapp create --resource-group myResourceGroupXX --plan myAppServicePlanXX --name bigfontdockerXX --deployment-container-image-name shaunluttin/temp:v0.0.1      
    az webapp log config --resource-group myResourceGroupXX --name bigfontdockerXX --web-server-logging filesystem      
    az webapp log tail --name bigfontdockerXX --resource-group myResourceGroupXX
