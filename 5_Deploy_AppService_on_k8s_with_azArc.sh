


# Task 1: Create a web app in an App Service Kubernetes environment
K8S_ARC_PREFIX=k8sArc
ARC_RG_NAME="rg-${K8S_ARC_PREFIX}-k8s-dev-001"
ARC_CLUSTER_NAME="${K8S_ARC_PREFIX}-lz-dev-001"

EXTENSION_NAME="${K8S_ARC_PREFIX}-kube"
KUBE_ENV_NAME=$(az appservice kube list -g $ARC_RG_NAME --query "[0].name" -o tsv)

CUSTOM_LOCATION_NAME="${K8S_ARC_PREFIX}-location"
CUSTOM_LOCATION_ID=$(az customlocation show -g $ARC_RG_NAME -n $CUSTOM_LOCATION_NAME --query id -o tsv)

WEBAPP_NAME=k8s-arc-webapp-dev-001
## az webapp list-runtimes --linux
az webapp create -g $ARC_RG_NAME -n $WEBAPP_NAME --custom-location $CUSTOM_LOCATION_ID --runtime "NODE|16-lts"

# Task 2: Deploy a Node.js-based application by using the zip-file deployment
git clone https://github.com/Azure-Samples/nodejs-docs-hello-world.git
cd nodejs-docs-hello-world
zip -r nodejs-docs-hello-world.zip .
az webapp deployment source config-zip -g $ARC_RG_NAME -n $WEBAPP_NAME --src nodejs-docs-hello-world.zip

kubectl get pods -n appservice-ns