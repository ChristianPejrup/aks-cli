param($name)

WriteAndSetUsage "aks devops environment check" ([ordered]@{
    "<name>" = "Environment Name"
})

CheckVariable $name "environment name"

Write-Info "Checking DevOps Environment"
AzDevOpsInvokeCheck environments environments "value[?name=='$name'].name" -exit
Write-Info "DevOps Environment exists"