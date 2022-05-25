#Vorbereitungen sind folgende:

# 1.Powershell muss die Administration per Remote-Powershell erlaubt werden. Auch möglich über GPO zu aktivieren.

# 2. Remotedesktop muss aktiviert werden (Zur Kontrolle). Auch möglich über GPO zu aktivieren.

# Zeige mir die installierte Software an:

Get-WmiObject Win32_Product -ComputerName $computername | Select-Object -Property IdentifyingNumber, Name

# Deinstalliere folgende Software:


cls 

$computername = "COMPUTERNAME"

$name1 = "WinJur Reports Runtime ""LL10"""
$name2 = "WinJur Call Manager 4.2.34"
$name3 = "WinJur ZED Import 3.8.0.0"
$name4 = "WinJur Tool Manager 4.0.17"
$name5 = "WinJur Resources 4.6.2"
$name6 = "WinJur Search Plus 3.8.2"
$name7 = "WinJur Shell Extension 2010 3.0.5 x64"
$name8 = "WinJur Reports Runtime ""Crystal""  11.8.1.2"
$name9 = "WinJur Reports Runtime ""LL19"""
$name10 = "WinJur Outlook Bridge 2013 4.5.9"
$name11 = "WinJur 2010 German 14.1.405"
$name12 = "WinJur BESR 3.7.2 (Programs)"
$name13 = "WinJur Data Preparation 4.1.0"
$name14 = "WinJur JL Register"

$Bodenname='$name'
$Nummeraufsteigend=1
$Schlaufeaufsteigend=0

do{
    $Zusammensetzen="$Bodenname$Nummeraufsteigend"
    $Namenfinden= $ExecutionContext.InvokeCommand.ExpandString($Zusammensetzen)
	Write-Host "Working on " $Namenfinden
	#(Get-WmiObject Win32_Product -ComputerName $computername | Where-Object {$_.name -eq $Namenfinden}).Uninstall()
	$Schlaufeaufsteigend++
    $Nummeraufsteigend++
} while ($Schlaufeaufsteigend -lt 14)

#GPUpdate (klappt nicht?)

#Invoke-GPUpdate -Computer $ComputerName -Force
#Write-Host "GPUpdate on " $ComputerName

# Starte folgenden Computer neu

Restart-Computer -ComputerName $ComputerName -Force

#Installiere den WJIntegration Dienst

Invoke-Command -ComputerName $Computername -InDisconnectedSession -ScriptBlock {New-Service -Name "WJIntegration" -BinaryPathName 'C:\Program Files (x86)\WinJur\Programs\WJIntegration\WJIntegration_Core.exe'}
Invoke-Command -ComputerName $Computername -InDisconnectedSession -ScriptBlock {Start-service -name "wjintegration"}

