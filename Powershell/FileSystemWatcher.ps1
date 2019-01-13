$folder = 'C:\Users\User\Documents\TrackingUsersGroups' # Enter the root path you want to monitor. 
$filter = '*.*'  # You can enter a wildcard filter here. 
 
# In the following line, you can change 'IncludeSubdirectories to $true if required.                           
$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories = $false;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'} 
 
# Here, all three events are registerd.  You need only subscribe to events that you need: 
 
Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action { 
$name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
Write-Host "The file '$name' was $changeType at $timeStamp" -fore green 
Out-File -FilePath 'C:\Users\User\Documents\TrackingUsersGroupsOutlog.txt' -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 
 
Register-ObjectEvent $fsw Deleted -SourceIdentifier FileDeleted -Action { 
$name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
Write-Host "The file '$name' was $changeType at $timeStamp" -fore red 
Out-File -FilePath 'C:\Users\User\Documents\TrackingUsersGroupsOutlog.txt' -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 
 
Register-ObjectEvent $fsw Changed -SourceIdentifier FileChanged -Action { 
$name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
Write-Host "The file '$name' was $changeType at $timeStamp" -fore white 
Out-File -FilePath 'C:\Users\User\Documents\TrackingUsersGroupsOutlog.txt' -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 