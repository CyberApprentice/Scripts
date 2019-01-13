Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs 
strArgs = "cmd /c clearTmpAndBin.bat"
oShell.Run strArgs, 0, false