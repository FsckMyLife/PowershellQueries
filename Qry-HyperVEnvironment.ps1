#Works for 2012R2
#Need to document requires amongst other things

$Results=@()
$Results2=@()
$QryHVServers=Get-ADObject -Filter 'ObjectClass -eq "serviceConnectionPoint" -and Name -eq "Microsoft Hyper-V"'
$Hypervisors= @($QryHVServers | Select-Object -Property @{label='DistinguishedName';expression={$_.distinguishedname -replace '^CN=Microsoft Hyper-V,CN=|,.*$'}})
$QryHVVMs=Get-ADObject -Filter 'ObjectClass -eq "serviceConnectionPoint" -and Name -eq "Windows Virtual Machine"'
$HVVMs= @($QryHVVMs | Select-Object -Property @{label='DistinguishedName';expression={$_.distinguishedname -replace '^CN=Windows Virtual Machine,CN=|,.*$'}})
foreach ($HyperVisor in $Hypervisors) {
$SvrObj=""
$SvrObj=Get-ADComputer $HyperVisor.distinguishedname
    $Dtl=""
            $Dtl = @{            
            Server  = $SvrObj.name
            DN        = $SvrObj.distinguishedname
            Role = "Hyper-V Host"
            }

     $Results+=New-Object PSObject -Property $Dtl 

}

foreach ($HVVM in $HVVMS) {
$SvrObj=""
$SvrObj=Get-ADComputer $HVVM.distinguishedname
    $Dtl2=""
            $Dtl2 = @{            
            Server  = $SvrObj.name
            DN        = $SvrObj.distinguishedname
            Role = "Hyper-V Guest"
            }

     $Results+=New-Object PSObject -Property $Dtl2

}
$Results #Here you go!