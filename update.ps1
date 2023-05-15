param (
    [Parameter(Mandatory=$false)]
    [string]$bat
)
$host.ui.RawUI.WindowTitle = "LiveStreamViewer Updater"
Write-Host "Do you wish to update LiveStreamViewer? [Y/N]"
$updateCONF = Read-Host
switch -Regex ($updateCONF) {
'Y|yes' {Write-Host "updating..."
    Remove-Item -Path "LiveStreamViewer.ps1"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CrazyKitty357/LiveStreamViewer/main/LiveStreamViewer.ps1" -OutFile "LiveStreamViewer.ps1" 
    Write-Host "The update was successful."
    Write-Host "You can view the changelog by typing " -nonewline
    Write-Host "[" -nonewline
    Write-Host "changelog" -nonewline -f yellow
    Write-Host "]" -NoNewLine
    Write-Host " in LiveStreamViewer."
    Pause
    Write-Host "Restarting..."
    Start-Sleep -Milliseconds 3500
    Clear-Host
    Powershell -File "LiveStreamViewer.ps1" $bat
}
'N|no' {Write-Host "Returning to main program..."
    Start-Sleep -Milliseconds 2000
    Clear-Host
    powershell -File "LiveStreamViewer.ps1" $bat}
}
