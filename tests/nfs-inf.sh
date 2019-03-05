#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

echo "creating nfs cluster"
az group deployment create \
--name NFSDeployment \
--resource-group $rgname \
   --template-uri "https://raw.githubusercontent.com/AzureCAT-GSI/SAP-HANA-S4/master/sap-nfs-service/azuredeploy-nfs-infra.json" \
   --parameters prefix=nfs \
   VMName1=$NFSVMNAME1 \
   VMName2=$NFSVMNAME2 \
   VMSize="Standard_D4s_v3" \
   vnetName=$vnetname \
   SubnetName=$appsubnetname \
   VMUserName=$vmusername \
   VMPassword=$vmpassword \
   OperatingSystem="SLES for SAP 12 SP3" \
   ExistingNetworkResourceGroup=$vnetrgname \
   StaticIP1=$NFSIP1 \
   StaticIP2=$NFSIP2 \
   iSCSIIP=$ISCSIIP \
   ILBIP=$NFSILBIP \
   DataDiskSize=$NFSDISKSIZE

echo "nfs cluster created"
