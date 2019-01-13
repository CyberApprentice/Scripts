#https://blogs.technet.microsoft.com/uktechnet/2016/06/20/parallel-processing-with-powershell/

& 'C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1' # run powercli initalization script


$ServerAddress = Read-Host "`n What is your ESXi/vSphere Server IP Address? (Ex: 192.168.1.1)" #prompt user for address 
$goodAddress = [ipaddress]$ServerAddress #utilizing ip address

Connect-VIServer $ServerAddress #powercli function to connect to the vsphere/esxi server

$servers = Get-VM | Where-Object {$_.PowerState -eq 'PoweredOff'} | Select-Object -ExpandProperty Name # store only VMs that can be backedup into array


<# Attempt 1
$serversPerBatch = 2

$j = 0
$j = $serversPerBatch - 1
$batch = 1

while ($i -lt $arrayOfVMs.Count)
{get
    $serverbatch = $arrayOfVMs[$i..$j]

    $jobname = "Batch$batch"
    Start-Job -Name $jobname -ArgumentList ($serverbatch) -ScriptBlock 
    {
        param ([string[]]$arrayOfVMs)
        foreach ($server in $arrayOfVMs)
        {
            Write-Host "hi"
        }
    } 

    $batch += 1
    $j = $j + 1
    $j =+ $serversPerBatch

    if ($j -gt $arrayOfVMs.Count) {$j = $arrayOfVMs.Count}
    if ($j -gt $arrayOfVMs.Count) {$j = $arrayOfVMs.Count}
}#>


workflow test {
param(
[string]$vcenter,
[string[]]$names,
[string]$session
)
foreach -parallel($name in $names){
$vm = InlineScript{
Add-PSSnapin VMware.VimAutomation.Core
Connect-VIServer -Server $Using:vcenter -Session $Using:session | Out-Null
Get-VM -Name $Using:name
}
$vm.Name
}
}
$vmNames = 'vm1','vm2','vm3'
test -names $vmNames -vcenter $global:DefaultVIServer.Name -session $global:DefaultVIServer.SessionSecret