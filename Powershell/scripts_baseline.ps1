$baseline = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\sigcheck_baseline.csv" ############CHANGE############
$temp = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\temp.csv" ############CHANGE############
$output = "C:\Users\IntenseMilk\Documents\Scripts\Sigcheck\sigcheck $(get-date -f yyyy-MM-dd-hh-mm-ss-tt).csv" ############CHANGE############
$command = C:\sysinternals\sigcheck64.exe -e -u -s C:\ ############CHANGE############
$wshell = New-Object -ComObject Wscript.Shell

#If baseline does not exist, create one.
if(![System.IO.File]::Exists($baseline))
{
    $command >> $baseline

    $wshell.Popup("Sigcheck Baseline Created.",0,"Done",0x1) ############CHANGE############
}

#If baseline does exist, create a new sigcheck and compare it with the baseline to find anamolies
else
{

$command >> $temp

if(Compare-Object -ReferenceObject $(Get-Content $baseline) -DifferenceObject $(Get-Content $temp))
    {
        Echo $timestamp "`n WARNING! Output of Baseline vs. Current:`n" >> $output

        Diff $baseline $temp -IncludeEqual | Format-Table InputObject, SideIndicator -AutoSize >> $output
    }

    Else 
    {
         Echo $timestamp "`nFiles are the same." >> $output

    }
    del $temp

$wshell.Popup("Sigcheck Compare Completed.",0,"Done",0x1) ############CHANGE############
}