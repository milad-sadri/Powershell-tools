 $Computer= "{ServerIP1,ServerIP2,ServerIP3}"

 $adminUserName="{server username}"

 $adminPassword="{server password}"

 $websiteName = "{website name}"

if (![string]::IsNullOrWhiteSpace($adminUserName)){
    $secpasswd = ConvertTo-SecureString $adminPassword -AsPlainText -Force
    $credential = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $adminUserName,$secpasswd
	$arrComputer = $Computer -split ','
     Write-Host "******************* Recycle IIS WebAppPoll ...(Take a few seconds) *******************"
	foreach ($iComputer in $arrComputer)
	{ 
        Try
        {
         Invoke-Command -ComputerName "$iComputer" -Credential $credential -ScriptBlock { param($websiteName,$iComputer)        
            Import-Module WebAdministration  

            Restart-WebAppPool $websiteName
            #Start-Sleep -s 30
         
         } -ArgumentList $WebsiteName,$iComputer
         Write-Host "Server [$iComputer] done!" -ForegroundColor Green
         Start-Sleep -s 3  

        }
        Catch
        {
            Write-Host "Could not operate on Server [$iComputer]!" -ForegroundColor Yellow
        }
	}
    Write-Host "******************* Recycle IIS WebAppPoll finished successfully! *******************"  -ForegroundColor Green
    }
