$everything = dir "C:\Users\User\Desktop\Rules" -Name
#for ($i =0; $i -le $everything.Count; $i++)
#{
 #   Write-Host " - $everything[$i] `n"
#}

Foreach($i in $everything)
{
    Write-Host " - $i"
}