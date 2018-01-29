#creating configMap for the Nginx frontend
kubectl create configmap config-files --from-file=nginx-conf=nginx.conf --save-config
kubectl label configmap config-files app=eshop

#Creating infrastructures (Ie databases,services bus and redis cache)
kubectl apply -f sql-data.yaml -f basket-data.yaml -f keystore-data.yaml -f rabbitmq.yaml -f nosql-data.yaml 

#Deploying code deployments (Web APIs, Web apps, ...)
kubectl apply -f services.yaml -f frontend.yaml

#Wait for the front-end url to be ready...for instance 51.141.160.253
frontendUrl="";
while [ -z "$frontendUrl" ];
do
frontendUrl=`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`
sleep 15;
done
externalDns=$frontendUrl;

#Create a new configuration map based on the frontendUrl or externalDns that the kubctl service returned
kubectl create configmap urls --save-config \
    --from-literal=BasketUrl=http://basket \
    --from-literal=BasketHealthCheckUrl=http://basket/hc \
    --from-literal=CatalogUrl=http://$externalDns/catalog-api \
    --from-literal=CatalogHealthCheckUrl=http://catalog/hc \
    --from-literal=PicBaseUrl=http://$externalDns/catalog-api/api/v1/catalog/items/[0]/pic/ \
    --from-literal=Marketing_PicBaseUrl=http://$externalDns/marketing-api/api/v1/campaigns/[0]/pic/ \
    --from-literal=IdentityUrl=http://$externalDns/identity \
    --from-literal=IdentityHealthCheckUrl=http://identity/hc \
    --from-literal=OrderingUrl=http://ordering \
    --from-literal=OrderingHealthCheckUrl=http://ordering/hc \
    --from-literal=MvcClientExternalUrl=http://$externalDns/webmvc \
    --from-literal=WebMvcHealthCheckUrl=http://webmvc/hc \
    --from-literal=MvcClientOrderingUrl=http://ordering \
    --from-literal=MvcClientCatalogUrl=http://catalog \
    --from-literal=MvcClientBasketUrl=http://basket \
    --from-literal=MvcClientMarketingUrl=http://marketing \
	--from-literal=MvcClientLocationsUrl=http://locations \
    --from-literal=MarketingHealthCheckUrl=http://marketing/hc \
    --from-literal=WebSpaHealthCheckUrl=http://webspa/hc \
    --from-literal=SpaClientMarketingExternalUrl=http://$externalDns/marketing-api \
    --from-literal=SpaClientOrderingExternalUrl=http://$externalDns/ordering-api \
    --from-literal=SpaClientCatalogExternalUrl=http://$externalDns/catalog-api \
    --from-literal=SpaClientBasketExternalUrl=http://$externalDns/basket-api \
    --from-literal=SpaClientIdentityExternalUrl=http://$externalDns/identity \
	--from-literal=SpaClientLocationsUrl=http://$externalDns/locations-api \
    --from-literal=LocationsHealthCheckUrl=http://locations/hc \
    --from-literal=SpaClientExternalUrl=http://$externalDns \
    --from-literal=LocationApiClient=http://$externalDns/locations-api \
    --from-literal=MarketingApiClient=http://$externalDns/marketing-api \
    --from-literal=BasketApiClient=http://$externalDns/basket-api \
    --from-literal=OrderingApiClient=http://$externalDns/ordering-api \
    --from-literal=PaymentHealthCheckUrl=http://payment/hc

kubectl label configmap urls app=eshop 

#Deploying configuration from conf_local.yml (externalcfg)
kubectl apply -f conf_local.yml

#Creating deployments...
kubectl apply -f deployments.yaml

#Remember that the deployements are Paused, we can now update the images with the latest from our Registery before resuming the deployement
dockerOrg="eshop"
registryPath="niyuen.azurecr.io/"
imageTag="latest"

kubectl set image deployments/basket basket=$registryPath$dockerOrg/basket.api:$imageTag
kubectl set image deployments/catalog catalog=$registryPath$dockerOrg/catalog.api:$imageTag
kubectl set image deployments/identity identity=$registryPath$dockerOrg/identity.api:$imageTag
kubectl set image deployments/ordering ordering=$registryPath$dockerOrg/ordering.api:$imageTag
kubectl set image deployments/marketing marketing=$registryPath$dockerOrg/marketing.api:$imageTag
kubectl set image deployments/locations locations=$registryPath$dockerOrg/locations.api:$imageTag
kubectl set image deployments/payment payment=$registryPath$dockerOrg/payment.api:$imageTag
kubectl set image deployments/webmvc webmvc=$registryPath$dockerOrg/webmvc:$imageTag
kubectl set image deployments/webstatus webstatus=$registryPath$dockerOrg/webstatus:$imageTag
kubectl set image deployments/webspa webspa=$registryPath$dockerOrg/webspa:$imageTag

#Resuming deployements
kubectl rollout resume deployments/basket
kubectl rollout resume deployments/catalog
kubectl rollout resume deployments/identity
kubectl rollout resume deployments/ordering
kubectl rollout resume deployments/marketing
kubectl rollout resume deployments/locations
kubectl rollout resume deployments/payment
kubectl rollout resume deployments/webmvc
kubectl rollout resume deployments/webstatus
kubectl rollout resume deployments/webspa



