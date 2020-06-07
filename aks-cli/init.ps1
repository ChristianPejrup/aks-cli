Clear-Host
az login -o none

New-Alias aks "$PSScriptRoot/aks.ps1" -Scope Global
New-Alias test "$PSScriptRoot/test.ps1" -Scope Global

function global:.. { Set-Location .. }
function global:... { Set-Location ../.. }
function global:.... { Set-Location ../../.. }

Register-BashArgumentCompleter az ~/.bashrc
Register-BashArgumentCompleter kubectl /usr/share/bash-completion/completions/kubectl.bash
Register-BashArgumentCompleter stern /usr/share/bash-completion/completions/stern.bash
Register-BashArgumentCompleter helm /usr/share/bash-completion/completions/helm.bash
Register-BashArgumentCompleter helm /usr/share/bash-completion/completions/helm3.bash

Set-Item -Path Env:KUBE_EDITOR -Value nano

aks switch

Clear-Host
aks