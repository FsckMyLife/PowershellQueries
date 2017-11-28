# This is quick and dirty way to log HP power consumption via iLO3 over a short period of time
     $Cred=Get-Credential
     $Server=Read-Host "Enter iLO server name"
     $Results=@()
     #Lazy loop
     $meow="1"
     while ($meow -eq "1"){
        $TmpDtl=""
        $Query=""
        $DT=""
        $Dt=Get-Date
        $Query=Get-HPiLOPowerReading -Server $Server -Credential $cred -DisableCertificateAuthentication
            $TmpDtl = @{            
            Avg = $Query.AVERAGE_POWER_READING
            Max = $Query.MAXIMUM_POWER_READING
            Min = $Query.MINIMUM_POWER_READING
            Cur = $Query.PRESENT_POWER_READING
            Dt  = $dt.DateTime
        }
     $Results+=New-Object PSObject -Property $TmpDtl 
    #save, wait, do it again
    $Results | ConvertTo-Html | Out-File C:\Scripts\iLOQueryResults.html -Append
    sleep 600
}