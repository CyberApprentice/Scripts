﻿#list accounts and compare with baseline

$timestamp = $(get-date -f yyyy-MM-dd-hh-mm-ss-tt)
$baseline = "C:\Users\IntenseMilk\Documents\Scripts\Check Accounts\account_baseline.csv"
$temp = "C:\Users\IntenseMilk\Documents\Scripts\Check Accounts\temp.csv"
$output = "C:\Users\IntenseMilk\Documents\Scripts\Check Accounts\account $timestamp.csv"
$command = net user
$wshell = New-Object -ComObject Wscript.Shell


#If baseline does not exist, create one.
if(![System.IO.File]::Exists($baseline))
{
    $command > $baseline

    $wshell.Popup("Account Baseline Created.",0,"Done",0x1)
}

#If baseline does exist, create a new sigcheck and compare it with the baseline to find anamolies
else
{

$command >> $temp

if(Compare-Object -ReferenceObject $(Get-Content $baseline) -DifferenceObject $(Get-Content $temp))
    {
        Echo $timestamp "`nOutput of Baseline vs. Current:`n" >> $output

        Diff $baseline $temp -IncludeEqual | Format-Table InputObject, SideIndicator -AutoSize >> $output
    }

    Else 
    {
         Echo $timestamp "`nFiles are the same" > $output

    }
    del $temp

$wshell.Popup("Account Compare Completed.",0,"Done",0x1)
}