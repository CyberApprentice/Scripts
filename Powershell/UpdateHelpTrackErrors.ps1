#Script that updates PowerShell's help modules. 
#Update this during inital PowerShell setup and periodically afterwards to maintain up-to-date modules

$error.clear() #clears any inital error logs

Update-Help -Module * -Force -ea 0 
#We don't just run "Update-Help" beacuse it might not update everything. Using "-Module * -Force" fixes that
# "-ea 0" hides errors

$ErrorOutput = #to store errors to put into output text file later
For($i = 0; $i -le $error.Count; $i++) #Loop that goes through each error
# -le = "length"
    {
      "`nerror $i"
      $error[$i].Exception
      "`n"
     
    } 
$ErrorOutput | Out-File "C:\Users\User\Desktop\UpdateHelpErrors.txt" #Output to text file
         
    