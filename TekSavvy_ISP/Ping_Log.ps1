<#
TekSavvy has asked me without knowing I have any idea about technology, proof I have a bad coax line to my house before they will send a field tech.
Fact of the matter is moisture is in the line. Every time humidity peaks 80% or higher there is significant package loss.
So I have made this tool with a quote from them of what they want to see.
This script runs on a scheduled task that runs for 23 hours 59 minutes 59 seconds until it is killed and restarted.
Every action is logged to prove to my ISP they need to take action for their paying customers.
It is really silly that this is required to get help in the year 2024...
#>


# QUOTE #

<#

1) Speed test one at a time, using speedtest.net and Speedtest.Shaw.ca Please note the default server used, ping, download and upload results when finished.

2) FAST.com - To adjust for high speed packages: Click 'Show More Info' Click 'Settings' Under Parallel Connections set the Min to 30 and the Max to 30, and set Test Duration Min/Max to 30. Check of the boxes for 'Measure loaded latency during upload', 'always show all metrics' Hit Save.

Note the returned values from the test.

3) IPconfig /all (or equivalent in OS)

4) Ping 127.0.0.1 -n 10 (just the summary is fine)

5) Ping -n 50 google.ca (just the summary is fine)

6) Tracert google.ca

7) Pathping -q 10 google.ca (if available)

#>

set-location -path "$env:USERPROFILE\Log"

$Timestamp = Get-Date -Format "yyyy-MM-dd_HH.mm_dddd" | foreach {$_ -replace ":", "."}

New-Item -Name "PING-Log_$Timestamp.txt"
$Log = "PING-Log_$Timestamp.txt"



Function Report {
Write-Host "
Running Command [" -ForegroundColor Yellow -BackgroundColor Black -NoNewline
Write-Host "$Command" -ForegroundColor Red -BackgroundColor Black -NoNewline
Write-Host "] and logging to file [" -ForegroundColor Yellow -BackgroundColor Black -NoNewline
Write-Host "$env:USERPROFILE\Log\$Log" -ForegroundColor Red -BackgroundColor Black -NoNewline
Write-Host "]" -ForegroundColor Yellow -BackgroundColor Black -NoNewline
"
##################################################
Running Command: [$Command]
"  | Out-File -Append $Log -NoClobber
}


Function TestNetwork {
Report


#$RunCommand | Out-File -Append $Log -NoClobber
  # Works, not outputting last command as it runs


$RunCommand | Tee $Log -Append
   # Same as above Out-File Command

Write-Host " --> Done!" -ForegroundColor Green -BackgroundColor Black
}



Function Ping8888 {
Report

ping 8.8.8.8 -t >> $Log
}



Function PingQ8 {
$PingTarget = "8.8.8.8"
Write-Host "
Pinging [$PingTarget], Please Wait." -ForegroundColor Yellow -BackgroundColor Black

If ((Test-NetConnection 8.8.8.8 -WarningAction SilentlyContinue).PingSucceeded -eq $false)
                      # You may need to edit the target some day
    {
    $Date = Get-Date -Format "yyyy-MM-dd_HH.mm" | foreach {$_ -replace ":", "."}
    Write-Host "Ping Test: [Failed]" -ForegroundColor Red -BackgroundColor Black
    "[$DATE] PING FAILED TO TARGET [$PingTarget]" | Tee $Log -Append
    }

ElseIf ((Test-NetConnection 8.8.8.8 -WarningAction SilentlyContinue).PingSucceeded -eq $true)
                          # You may need to edit the target some day
    {
    $Date = Get-Date -Format "yyyy-MM-dd_HH.mm" | foreach {$_ -replace ":", "."}
    Write-Host "Ping Test: [Successful]" -ForegroundColor Green -BackgroundColor Black
    "[$DATE] ping successful to target [$PingTarget]" | Tee $Log -Append
    }
LoopPingQ8
}


Function LoopPingQ8 {
Write-Host "Looping Ping Test..." -ForegroundColor Cyan -BackgroundColor Black
PingQ8
}


<#
Function PingQ8 {
Report

$TestTarget = "8.8.8.8"
$Test = test-connection $TestTarget -count 4 -TimeToLive 116 | Tee $Log -Append

Start-Sleep -Seconds 5

Write-Host "
59 min ping test done. Looping function now...
" -ForegroundColor Cyan -BackgroundColor Black

PingQ8
}
#>

Function Status {
$StepTotal = "6"
Write-Host "Step [$StepCount] of [$StepTotal]" -Foreground Cyan -Background Black
}

$StepCount = "1"
Status
$Command = "ipconfig /all"
$RunCommand = ipconfig /all
TestNetwork

$StepCount = "2"
Status
$Command = "Ping 127.0.0.1 -n 10"
$RunCommand = Ping 127.0.0.1 -n 10
TestNetwork

$StepCount = "3"
Status
$Command = "Ping -n 50 google.ca"
$RunCommand = Ping -n 50 google.ca
TestNetwork

$StepCount = "4"
Status
$Command = "Tracert google.ca"
$RunCommand = Tracert google.ca
TestNetwork

$StepCount = "5"
Status
$Command = "Pathping -q 10 google.ca"
$RunCommand = Pathping -q 10 google.ca
TestNetwork

$StepCount = "6"
Status
$Command = "test-connection $Q8 -count 3540 -TimeToLive 116"
#$RunCommand = ping -t 8.8.8.8 | foreach{"{0} - {1}" -f (Get-Date),$_}
#$RunCommand = Ping.exe -t 8.8.8.8 | ForEach {“{0} – {1}” -f (Get-Date),$_} #| Tee $Log
PingQ8