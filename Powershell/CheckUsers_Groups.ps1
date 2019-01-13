#C:\Users\User\Documents\WindowsPowerShell\FileSystemWatcher.ps1


$timestamp = $(get-date -f yyyy-MM-dd-hh-mm-ss-tt)
$baseline = "C:\Users\IntenseMilk\Documents\Scripts\Check Users & Groups\checkUsers&Groups_Baseline.csv"
$command = {"`n~~~~~~~~~~~~~~~~~~~~~~~~~~~Get-WmiObject~~~~~~~~~~~~~~~~~~~~~~~~~~~`n"; 
            Get-WmiObject -Class Win32_UserAccount; 
            "`n~~~~~~~~~~~~~~~~~~~~~~~~~~~Get-LocalUser~~~~~~~~~~~~~~~~~~~~~~~~~~~`n";
            Get-LocalUser; 
            "`n~~~~~~~~~~~~~~~~~~~~~~~~~~~Get-LocalGroup~~~~~~~~~~~~~~~~~~~~~~~~~~~`n";
            Get-LocalGroup
            }
$temp = "C:\Users\IntenseMilk\Documents\Scripts\Check Users & Groups\temp.csv"
$output = "C:\Users\IntenseMilk\Documents\Scripts\Check Users & Groups\$timestamp.csv"
$wshell = New-Object -ComObject Wscript.Shell


#If baseline does not exist, create one.
if(![System.IO.File]::Exists($baseline))
{
    $command.invoke() > $baseline

    $wshell.Popup("Users&Groups Baseline Created.",0,"Done",0x1)
}

#If baseline does exist, create a new sigcheck and compare it with the baseline to find anamolies
else
{

$command.invoke() >> $temp

if(Compare-Object -ReferenceObject $(Get-Content $baseline) -DifferenceObject $(Get-Content $temp))
    {
        Echo $timestamp "`nWARNING! Output of Baseline vs. Current:`n" >> $output

        Diff $baseline $temp -IncludeEqual | Format-Table InputObject, SideIndicator -AutoSize >> $output
    }

    Else 
    {
         Echo $timestamp "`nFiles are the same" > $output

    }
    del $temp

$wshell.Popup("Users&Groups Compare Completed.",0,"Done",0x1)
}

