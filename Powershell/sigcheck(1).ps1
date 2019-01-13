C:\sysinternals\sigcheck64.exe -e -u -s C:\ >> $HOME\Desktop\"sigcheck $(get-date -f yyyy-MM-dd-hh-mm-ss-tt).txt.csv"

$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Sigcheck Completed",0,"Done",0x1)