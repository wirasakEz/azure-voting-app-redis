


# Task 1: Deploy an AKS cluster
K8S_CLUSTER_RG_NAME=rg-aks-k8s-dev-001
K8S_CLUSTER_NAME=k8s-aks-lz-dev-001
LOCATION=eastus

az group create -l $LOCATION -n $K8S_CLUSTER_RG_NAME
az aks create -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME -l $LOCATION --enable-aad --generate-ssh-keys

# Task 2: Connect to the AKS cluster
az aks get-credentials -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --admin
kubectl get ns