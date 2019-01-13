<#
   1) comment everything
   2) change the execution policy
   3) custom powercli location
#>


########################### Initializing PowerCLI w/ admin ###########################

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) #if statement
{ #begin if statement
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
} #end if statement



Set-ExecutionPolicy  RemoteSigned
try
{#begin try block
    $checkPowerCLI = Test-Path -Path 'C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1'
    if($checkPowerCLI -eq $false)
    {#begin if statement
        throw "Doesn't have PowerCLI"
    }
}
catch [exception]
{
    Write-Warning "This script will not work without PowerCLI installed. Google 'Download VMware PowerCLI'"
    Start-Sleep -s 5
    exit
}

& 'C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1'
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore


Write-Warning "Administrative Priviledges are needed in case you store the files in an unauthorized location and to connect to the server. Thank you for your understanding."
################## Connecting to server ##################
do
{
    try 
    {
        $goodAddress = $true
        $Server = Read-Host "`n What is your ESXi/vSphere Server IP Address? (Ex: 192.168.1.1)"
        $goodAddress = [ipaddress]$Server
    }

    catch [exception]
    {
        Write-Warning "Invalid IPv4 Address! Try again!"
        Start-Sleep -s 1
        $goodAddress = $false
    }
} While ($goodAddress -eq $false)

Write-Output "`nA popup titled 'Specify Credential' will apear in 10 seconds. Please fill it in to connect to the server 'securely'"

do
{
    try 
    {
        $restartLoop = 0
        Write-Output "`nYou are now connecting to Server ($Server). Please hold"
        Connect-VIServer $Server
        clear
        $Array = Get-VM | Select-Object -ExpandProperty Name 
        Write-Host ''
    }

    catch [exception]
    {
        Write-Warning "There was an error connecting to the server. It could be one of the following:`n1) The username and password were incorrect.`n2) The server is offline.`n3) You did not fill out the popup at all.`n4) If you cannot continue past this message, the PowerCLI script might be broken. Examine this script in Powershell ISE."
        Read-Host "`nPress any key to try again"
        $restartLoop = $null
        clear
    }
} While ($restartLoop -eq $null)

Write-Output "You have successfully connected to $Server!"




##################  Questions & Necessary Variables ####################
while("all","many","one" -notcontains $Choice)
{
        $Choice = Read-Host "Do you want to backup ALL VMs (type 'all'), just one (type 'one') specific ones (type 'many')?"
}


do
{
    try 
    {
        $goodDirectory = $true
        $Destination = Read-Host "`nWhere is the absolute path you want to store the backup(s)? Default is current directory (which is $pwd). (Ex: C:\Users\Example\Desktop)"

        if($Destination -eq "")
        {
          $Destination = $pwd  
        }

        $goodDirectory = Test-Path -Path $Destination
        
        if ($goodDirectory -eq $false)
        {#begin if statement
            md -Force $Destination | Out-Null
            $goodDirectory = $true
        }
    }
    catch [exception]
    {
        Write-Warning "Invalid Directory! Try again!"
        Start-Sleep -s 1
        $goodDirectory = $false
    }
} While ($goodDirectory -eq $false)


Write-Output (Get-VM | Select-Object Name,PowerState | ft -AutoSize)

$blank = 0
while ($blank -notmatch "")
{
    $blank = Read-Host "`nCheck that all of the VMs you want exported are powered off. When verified click enter"
}



Read-Host "`nCheck that all of the VMs you want exported are powered off. When verified click enter to continue"


Write-Output "`nOVF is a file format that supports exchange of virtual appliances across products and platforms.`nOVA is a single file distribution of the same file package"
$FileExtension = Read-Host "`nExport as ovf or ova? (Definitions above)"

while("ovf","ova" -notcontains $FileExtension)
{
        $FileExtension = Read-Host "`nExport as ovf or ova?"
}
 

 ############# Backing up ALL available VMs ###################
if ($Choice -like 'all')
{#begin if statement
    Write-Output (Get-VM | Select-Object Name | ft -AutoSize)
    ######## Checking before continuing ###########
    $blank = ""
    while ($blank -notmatch "[y|n]")
    {
        $blank = Read-Host "`nThe above VMs will be exported as an $FileExtension at ($Destination). Do you want to continue? (Y/N)"
    }

    if ($blank -eq "n")
    {
        exit
    }

    ######### Backing up ALL loop############
    try
    {
        foreach($vm in $Array)
        {
            Write-Output "`n We're now exporting $vm to an $FileExtension. Press Ctrl+C to stop.`n"
            Get-VM –Name $vm | Export-VApp –Destination $Destination –Format $FileExtension -force
        }
    }
    catch [exception]
    {
        Write-Host ''
        Write-Warning "$vm failed to export as a $FileExtension! This does not mean the others will fail."
        while ($blank -notmatch "[y|n]")
        {
            $blank = Read-Host "`nDo you want to continue? (Y/N)"
        }

        if ($blank -eq "n")
        {#begin if statement
            exit
        }
    }
}

############ Backing up one VM ##############
elseIf($Choice -like 'one')
{
    $counter = 1
    Write-Output ''

    foreach($VMname in $Array)
    {
        Write-Output "$counter. $VMname"
        $counter++
    }


    do #START of valdiate for requested VMs 
    {
        try 
        {
            $goodNumber = $true
            [int]$RequestedVM = Read-Host "`nWhich of the above VMs do you want to back up by the matching number? (Ex: 1)"

            if($RequestedVM -gt $counter -Or $RequestedVM -lt 1)
            {#begin if statement
                throw "Number higher or lower than available VMs"
            }
        }

        catch [exception]
        {
            Write-Warning "Only one number from 1 to $($counter-1)! Try again!"
            Start-Sleep -s 1
            $goodNumber = $false
        }

    


    } While ($goodNumber -eq $false) # END of valdiate for requested VMs 

    For ($index=0; $index -lt $RequestedVM.Length; $index++)
    {
        Write-Output "`nWe're now exporting $($Array[$RequestedVM[$index]-1]) to an $FileExtension. Press Ctrl+C to stop.`n"
        Get-VM –Name $($Array[$RequestedVM[$index]-1]) | Export-VApp –Destination $Destination –Format $FileExtension -force
    }
}

############ Backing up VMs Individually ##############
else
{
    $counter = 1
    Write-Output ''

    foreach($VMname in $Array)
    {
        Write-Output "$counter. $VMname"
        $counter++
    }
    
    do # START of valdiate for requested VMs 
    {
        try 
        {
            $goodNumbers = $true
            Write-Host ''
            Write-Warning "If you only input one value, this will not work and you'll have to restart."
            $RequestedVMs = Read-Host "`nWhich of the above VMs do you want to back up by the matching number? (Ex: 1,4, 5, 10,   7,2,1)"
        
            $RequetedVMsAsAnObject = $RequestedVMs.ToCharArray()
            $maximumInputNumber = ($RequestedVMs.ToCharArray() -replace "\D" , "" | measure -Maximum).Maximum # This will give the CORRECT maximum but NOT in order correctly
            #($RequestedVMs.ToCharArray() -match "^[\d\.]+$" | Sort-Object | measure -Maximum | select Maximum).Maximum # This will put the user inputted numbered IN ORDER but will give an INCORRECT MAXIMUM
            $minimumInputNumber = ($RequestedVMs.ToCharArray() -replace "\D" , "" | measure -Minimum).Minimum


            if($maximumInputNumber -gt $counter -Or ($minimumInputNumber+1) -lt 1)
            {#begin if statement
                throw "Number higher or lower than available VMs"
            }
            
            if($RequetedVMsAsAnObject.length -le 1)
            {#begin if statement
                throw "Only one number, not many."
            }
        }
        
        catch [exception]
        {
            Write-Warning "Only NUMBERS from 1 to $($counter-1)! Try again!"
            Start-Sleep -s 1
            $goodNumbers = $false  
        }

        <#
        catch #[System.Management.Automation.RuntimeException]
        {
            Write-Warning "You only entered one number, this is the 'many' function. Restart the script to do one."
            Start-Sleep -s 1
            $goodNumbers = $false
        }
        catch #[System.Management.Automation.RuntimeException] 
        {
            Write-Warning "Only numbers from 1 to $($counter-1)! Try again!"
            Start-Sleep -s 1
            $goodNumbers = $false
        }#>

    } While ($goodNumbers -eq $false) # END of valdiate for requested VMs 

    
    $individualVMs = [regex]::split($RequestedVMs, '[,\s]+') | Select-Object -Unique | Sort-Object           #Regex to split the selected VMs to iterate through
    For ($index=0; $index -lt $individualVMs.Length; $index++)
    {
            Write-Output "$($individualVMs[$index]). $($Array[$individualVMs[$index]-1])"
    }

    

    ######## Checking before continuing ###########
    $blank = ""

    while ($blank -notmatch "[y|n]")
    {
        $blank = Read-Host "`nThe above VMs will be exported as an $FileExtension at ($Destination). Do you want to continue? (Y/N)"
    }

    if ($blank -eq "n")
    {#begin if statement
        exit
    }

    For ($index=0; $index -lt $individualVMs.Length; $index++)
    {
            Write-Output "`nWe're now exporting $($Array[$individualVMs[$index]-1]) to an $FileExtension. Press Ctrl+C to stop.`n"
            Get-VM –Name $($Array[$individualVMs[$index]-1]) | Export-VApp –Destination $Destination –Format $FileExtension -force
    }
}

Write-Host "`nAll done! Just disconnect from the server below." # 
Write-Host "" # new line for clarity 
Disconnect-VIServer -Server * -Force # disconnect from server(s)