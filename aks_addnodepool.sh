RG=
CLUSTER=
az aks nodepool add --resource-group $RG --cluster-name $CLUSTER --name userpool2 --node-count 1 --mode User