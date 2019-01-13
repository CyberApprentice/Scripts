## Pulls data from an AV to be added to the hosts blacklist

# All json files contained in C:\ProgramData\Malwarebytes\MBAMService\MwacDetections
$antiVirusPath = "C:\ProgramData\Malwarebytes\MBAMService\MwacDetections";
$jsonFiles = Get-ChildItem $antiVirusPath -Filter *.json
$finalOutput "C:\Users\perry\Desktop\final.txt "

# Loop to go through each file individually
for ($index=0; $index -lt $jsonFiles.Count; $index++) {

    # Get the content of the file and convert it 
    $jsonFileContent = Get-Content $jsonFiles[$index].FullName | select -Skip 1 | Out-String | ConvertFrom-Json 
    $url = $jsonFileContent.threats.mainTrace.websiteData.url 

    Add-Content C:\Users\perry\Desktop\test.txt  "127.0.0.1  $($url)"
}

Get-Content C:\Users\perry\Desktop\test.txt | Select -Unique | Add-Content $finalOutput
del C:\Users\perry\Desktop\test.txt