$baseline = "C:\Users\IntenseMilk\Documents\Scripts\listDLLs\listDLLs_baseline.csv"
$temp = "C:\Users\IntenseMilk\Documents\Scripts\listDLLs\temp.csv"
$output = "C:\Users\IntenseMilk\Documents\Scripts\listDLLs\Listdlls $(get-date -f yyyy-MM-dd-hh-mm-ss-tt).csv"
$command = C:\sysinternals\Listdlls64.exe -u
$wshell = New-Object -ComObject Wscript.Shell

#If baseline does not exist, create one.
if(![System.IO.File]::Exists($baseline))
{
    $command >> $baseline

    $wshell.Popup("listDLLs Baseline Created.",0,"Done",0x1)
}

#If baseline does exist, create a new sigcheck and compare it with the baseline to find anamolies
else
{

$command >> $temp

if(Compare-Object -ReferenceObject $(Get-Content $baseline) -DifferenceObject $(Get-Content $temp))
    {
        Echo $timestamp "`nWARNING! Output of Baseline vs. Current:`n" >> $output

        Diff $baseline $temp -IncludeEqual | Format-Table InputObject, SideIndicator -AutoSize >> $output
    }

    Else 
    {
         Echo $timestamp "`nFiles are the same" >> $output

    }
    del $temp

$wshell.Popup("listDLLs Compare Completed.",0,"Done",0x1)
}