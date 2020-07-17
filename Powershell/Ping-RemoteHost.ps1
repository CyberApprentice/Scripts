<#
.Synopsis
   Test connectivity to the Internet
.DESCRIPTION
   The goal is have a better idea of the frequency of failed ICMP connections. It is meant to be monitored in the foreground, but can be altered to run in the background. The IP address used is 8.8.8.8 because most of the time, an Internet connection is what I'm taken. This can be manually altered, or the program can be changed to accept user input.
.EXAMPLE
   .\Ping-RemoteHost.ps1
#>
function Verb-Noun
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [int]$Param2
    )

    Begin
    {
        $WarningPreference = 'SilentlyContinue'# Ignore Warnings
    }
    Process
    {
        while($true)
        {
            start-sleep -s 1 # Pause for 1 second
            if(!(Test-NetConnection 8.8.8.8 -InformationLevel Quiet)) # if it fails to ping the ip address
            {
                Write-host "Ping to 8.8.8.8 failed at $(get-date)"
                Write-host "Waiting 5 seconds before continuing pings."
                start-sleep -s 5
                Write-host "Continuing pings..."
            }
        }
    }
    End
    {
    }
}