Write-Host "Starting"
Start-Sleep -s 2
[bool] $keepRunning = 1
[bool] $everFound = 0
[bool] $searchComplete = 0
:main while($keepRunning)
{
    $inFile = Get-Content -path ".\input.txt"
    $completed = Get-Content -Path ".\output.txt"
    $line = $inFile[0]
    #$holder = $null
    if($inFile.count -eq 1)
    {
        $line = $inFile
    }

    # create condition to check if $line matches any line in completed.txt
    # if it does, skip this line and move on to the next line
    :search while($everFound -eq 0 -and $searchComplete -eq 0)
    {
        #Write-Host "Outer loop"
        foreach($url in $completed)
        {
            #Write-Host $line
            #write-host $url
       
            if ($line -eq $url)
            {
                Write-Host "`nThis file was already downloaded --Skipping to the next line"
                $inFile = Get-Content -path ".\input.txt" | where-object {$_ -notmatch [regex]::Escape($line)}
                set-content -path ".\input.txt" -Value $inFile
                $inFile = Get-Content -path ".\input.txt"
                $line = $inFile[0]
                $everFound = 1
                Start-Sleep -s 2
                break
            }
        }
        if ($everFound -eq 1)
        {
            break
        }
        $searchComplete = 1
        #Write-Host "Search Complete`n"
    }
    #Write-Host "Before the download--------"

    # Write-Host $everFound
    # Write-Host $searchComplete

    if ($everFound -eq 0 -and $searchComplete -eq 1)
    {
        #download the files
        $downloadCommand = "youtube-dl.exe --verbose `"$line`""
        get-date
        invoke-Expression $downloadCommand
        
        #delete the url
        add-content -Path ".\output.txt" -Value $line
        #$holder = Get-Content -path ".\input.txt" | where-object {$_ -notmatch [regex]::Escape($line)} 
        $inFile = Get-Content -path ".\input.txt" | where-object {$_ -notmatch [regex]::Escape($line)} 
        set-content -path ".\input.txt" -Value $inFile
        write-host "`n"
        
        get-date
        Write-Host "Sleeping for 45mins"
        start-sleep -s 2700
    }
    $everFound = 0
    $searchComplete = 0
    #Write-Host "-------------After the download!!"
    #Write-Host $everFound
    #Write-Host $searchComplete


    # check if the file is empty. If it is, set the keepRunning flag to false and exit the main while loop
    if($Null -eq $inFile)
    {
        $keepRunning = 0
    }
}

Write-Host "Done"
Read-Host "Press the Enter Key to Exit"