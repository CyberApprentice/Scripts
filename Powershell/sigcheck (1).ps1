$baseline = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\sigcheck_baseline.csv"
$temp = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\temp.csv"
$output = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\sigcheck $(get-date -f yyyy-MM-dd-hh-mm-ss-tt).csv"
$sigcheck = C:\sysinternals\sigcheck64.exe -e -u -s C:\
$wshell = New-Object -ComObject Wscript.Shell

#If baseline does not exist, create one.
if(![System.IO.File]::Exists($baseline))
{
    $sigcheck >> $baseline

    $wshell.Popup("Sigcheck Completed",0,"Done",0x1)
}

#If baseline does exist, create a new sigcheck and compare it with the baseline to find anamolies
else
{

$sigcheck >> $temp

if(Compare-Object -ReferenceObject $(Get-Content $baseline) -DifferenceObject $(Get-Content $temp))
    {
        Echo $timestamp "`nOutput of Baseline vs. Current:`n" >> $output

        Diff $baseline $temp -IncludeEqual | Format-Table InputObject, SideIndicator -AutoSize >> $output
    }

    Else 
    {
         Echo $timestamp "`nFiles are the same" >> $output

    }
    del $temp

$wshell.Popup("Sigcheck Compare Completed",0,"Done",0x1)
}