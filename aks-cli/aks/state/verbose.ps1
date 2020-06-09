param([switch] $disable)

WriteAndSetUsage "aks state verbose" ([ordered]@{
    "[-disable]" = "Flag to disable verbose output"
})

if (!$disable)
{
    Write-Info "Setting global state to verbose output"
}
else 
{
    Write-Info "Setting global state to non-verbose output"
}

SetVerboseState $disable