del %temp% /S /Q /F
del %temp% /S /Q /A:H
FOR /D %%p IN ("%temp%*") DO rmdir "%%p" /s /q

del C:\Windows\Temp /S /Q /F
del C:\Windows\Temp /S /Q /A:H
FOR /D %%p IN ("C:\Windows\Temp\*") DO rmdir "%%p" /s /q

rd /s /q %systemdrive%\$Recycle.bin