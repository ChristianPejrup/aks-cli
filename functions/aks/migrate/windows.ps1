# TODO: Implement & Test
# TODO: Create 'Migrate' menu
param($resourceGroupName, $windowsAdminUsername, $windowsAdminPassword, $location, $nodeCount, $nodeSize, $windowsNodeCount, $windowsNodeSize, $windowsNodePoolName)

WriteAndSetUsage "aks setup windows <resource group name> <windows admin username> <windows admin password> [location] [node count] [node size] [windows node count] [windows node size] [windows nodepool name]"

SetDefaultIfEmpty ([ref]$windowsNodePoolName) 'winvms'
$nodeSizeString = ""
SetDefaultIfEmpty ([ref]$nodeSizeString) " --node-vm-size $nodeSize"
SetDefaultIfEmpty ([ref]$windowsNodeSize) "Standard_H8"

$resourceGroupExist = ExecuteQuery "az group exists -n $resourceGroupName $debugString"
if (!$resourceGroupExist -and !$location) {
    WriteUsage
    Write-Info "When the resource group does not exist, the location must be specified: [location]"
    exit
}
CheckLocationExists $location
CheckNumberRange ([ref]$nodeCount) "node count" -min 2 -max 100 -default 2
CheckNumberRange ([ref]$windowsNodeCount) "windows node count" -min 2 -max 100 -default 2
CheckVariable $resourceGroupName "resource group name"
CheckVariable $windowsAdminUsername "windows admin username"
CheckVariable $windowsAdminPassword "windows admin password"

ExecuteCommand "aks create windows $resourceGroupName $windowsAdminUsername $windowsAdminPassword $location $nodeCount $nodeSize $windowsNodeCount $windowsNodeSize $windowsNodePoolName"

ExecuteCommand "aks credentials get $resourceGroupName"

ExecuteCommand "aks tiller install"
ExecuteCommand "aks tiller wait"
ExecuteCommand "aks monitoring install"
ExecuteCommand "aks insights install"