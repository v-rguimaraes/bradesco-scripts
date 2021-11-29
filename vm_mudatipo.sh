
#DS3_v2
#DS2_v2

RG=
VMNAME=

az vm resize -g $RG -n $VMNAME --size Standard_DS3_v2
az vm disk attach --vm-name $VMNAME --resource-group $RG --disk "vm-disc-232323243" --new  --size-gb 128 --sku Standard_LRS 
