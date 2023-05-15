@echo off
title LiveStreamViewer
color 0f
set bat=Y
powershell.exe -ExecutionPolicy Bypass -File "LiveStreamViewer.ps1" "%bat%"