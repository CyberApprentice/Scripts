<#
        This script will carry out daily netstat -anb commands and compare each one to the previous baseline.
        If it finds a new entry, it'll alert me and I'll decide whether to append it to the baseline or act on it.
#>

    

$(netstat -anb) > ("netstat-anb_" + $(Get-Date).toString("dd-mm-yyyy") + ".txt")