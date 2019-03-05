#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi


echo "installing ntp server software"
az group deployment create \
--name NTPDeployment \
--resource-group "$rgname" \
--template-uri "https://raw.githubusercontent.com/AzureCAT-GSI/SAP-HANA-S4/master/sap-ntp-server/ntpserver-sw.json" \
--parameters \
vmUserName=$vmusername \
ExistingNetworkResourceGroup="$rgname" \
vnetName="$vnetname" \
subnetName="$mgtsubnetname" \
osType="SLES 12 SP3" \
vmPassword="$vmpassword" \
customUri="$customuri" \
StaticIP="$NTPIP"

echo "ntp server software installed"
