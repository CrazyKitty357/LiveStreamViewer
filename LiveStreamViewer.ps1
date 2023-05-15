$bat = $args[0]
$host.ui.RawUI.WindowTitle = "LiveStreamViewer"
if (Get-Item "C:\Program Files\Google\Chrome\Application\chrome.exe" -ErrorAction SilentlyContinue) {
    $Browser = "Chrome"
    Write-Host "Google Chrome is installed." -ForegroundColor Green
} else {
    $Browser = "Default"
    Write-Host "Google Chrome is not installed " -ForegroundColor Red -NoNewline
    Write-Host "however it is not required." -ForegroundColor Black -BackgroundColor Yellow
}

if (Get-Item "YTtoken.txt" -ErrorAction SilentlyContinue) {

    Write-Host "YouTube API key is set" -ForegroundColor Green
    $YTapifile = "Y"
} else {

    Write-Host "YouTube API key is not set " -ForegroundColor Red -NoNewline
    Write-Host "would you like to set it? [Y/N]"
    $YTapiAnwser = Read-Host
    switch -regex ($YTapiAnwser) {
        'Y|y' {Write-Host "What is your YouTube API key?"
        Write-Host "If you don't know how to get it you can read this offical tutorial"
        Write-Host "https://developers.google.com/youtube/v3/getting-started" -ForegroundColor Blue
        Write-Host "Once you are done come back and paste it here:" -NoNewline
        $YTapi = Read-Host
        Clear-Host
        Write-Host "$YTapi"
        Write-Host "Are you sure this is correct? [Y/N]"
        $YTapiCONF = Read-Host
             switch -regex ($YTapiCONF) {
                'Y|y' {Write-Host "Making file..."
                $YTapi | Out-File -FilePath .\YTtoken.txt
                Write-Host "File has been made"
                $YTapifile = "Y"
                if ($bat -eq "Y") {Start-Process "run.bat"}
                if ($null -eq $bat) {Clear-Host 
                Powershell -File "LiveStreamViewer.ps1"}
                exit}
                'N|n' { $YTapifile = "N"
                Write-Host "Not making file and finishing setup..."}
            }
        }
        'N|n' {Write-Host "Skipping Setup."
                    $YTapifile = "N"}}
    Start-Sleep -Milliseconds 2000
    Clear-Host
}
Write-Host "Version Release 1.0 Type [" -NoNewline
Write-Host "changelog" -ForegroundColor Yellow -NoNewline
Write-Host "/" -NoNewline
Write-Host "log" -ForegroundColor Yellow -NoNewline
Write-Host "] to view the changelog"
Write-Host "You can type [" -NoNewline
Write-Host "update" -NoNewline -ForegroundColor Yellow
Write-Host "] to update the application"


if ($YTapifile -eq "Y") {Write-Host ""
Write-Host "Do you want to watch Twitch, YouTube or HoloDex? ["-NoNewLine}
else { Write-Host "YouTube API key has not been found falling back..."
Write-Host "Do you want to watch Twitch or Holodex? ["-NoNewline}
Write-Host "TTV" -NoNewline -ForegroundColor Magenta
if ($YTapifile -eq "N") {Write-Host "" -NoNewline}
else {Write-Host "/" -NoNewline
    Write-Host "YT" -NoNewline -ForegroundColor Red}
Write-Host "/" -NoNewLine
Write-Host "HD" -NoNewLine -ForegroundColor Blue
Write-Host "]"
Write-Host "You can type [help] to view all commands"

$platform = Read-Host 
switch -regex ($platform) {
    'variables|var' {$Splatform = Get-Content "platform.txt"
        $TTVstreamer = Get-Content "streamer.txt"
        $channel_id = Get-Content "channel_id.txt"
        $video_id = Get-Content "video_id.txt"
        $handle = Get-Content "handle.txt"
        $client_id = Get-Content "Twitchclient_id.txt"
        $accessToken = Get-Content "Twitchtoken.txt"
        $YTapi = Get-Content "YTtoken.txt"
        $vod_id = Get-Content "vod_id.txt"
        Clear-Host
        Write-Host "SAVED VARIABLES"
        Write-Host ""
        Write-Host "recent platform = $Splatform"
        Write-Host ""
        Write-Host "TWITCH VARIABLES"
        Write-Host "recent twitch streamer = $TTVstreamer"
        Write-Host "recent twitch vod = $vod_id"
        Write-Host ""
        Write-Host "YOUTUBE VARIABLES"
        Write-Host "recent handle = $handle"
        Write-Host "recent channel id = $channel_id"
        Write-Host "recent video id = $video_id"
        Write-Host ""
        Write-Host "KEYS, TOKENS & IDs"
        if ($null -eq $client_id) {Write-Host "Twitch client id = not set"} else {
        Write-Host "Twitch client id = $client_id"}
        if ($null -eq $accessToken) {Write-Host "Twitch access token = not set"} else {
        Write-Host "Twitch access token = $accessToken"}
        if ($null -eq $YTapi) {Write-Host "YouTube api key = not set"} else {
        Write-Host "YouTube api key = $YTapi"}
        Write-Host ""
        Write-Host "You can reverse search these by pasting the links in your browser of choice"
        Write-Host ""
        Write-Host "YOUTUBE"
        Write-Host "https://www.youtube.com/@$handle" -ForegroundColor Blue
        Write-Host "https://www.youtube.com/channel/$channel_id" -ForegroundColor Blue
        Write-Host "https://www.youtube.com/watch?v=$video_id" -ForegroundColor Blue
        Write-Host ""
        Write-Host "TWITCH"
        Write-Host "https://www.twitch.tv/$TTVstreamer" -ForegroundColor Blue
        Write-Host "https://www.twitch.tv/videos/$vod_id" -ForegroundColor Blue
        Write-Host ""
        Pause
        if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit
    }

    'followlist|follows|follow' {
        Clear-Host
        Write-Host "Now viewing your Follow List"
        Write-Host "If you input a "-NoNewline
        Write-Host "!"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
        Write-Host " the program will go back to the previous screen"
        Write-Host ""
        
# Specify the path to the text file
$filePath = "FollowList.txt"

# Read the contents of the text file
$lines = Get-Content $filePath

# Check if the list is empty
if ($lines.Count -eq 0) {
    Write-Host "The follow list is empty."
    Write-Host "You need to add at least 2 streamers in the list to use this feature"
    Write-Host "Would you like to do that now?"
    $FollowListSetup = Read-Host
    if ($FollowListSetup -eq "y") {
        Write-Host "Who is the first person you want to add?"
        $newfollow1 = Read-Host
        if ($newfollow1 -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
        Write-Host "Where do they stream [TTV/YT]"
        $newfollowPlatform1 = Read-Host
        if ($newfollowPlatform1 -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
        $line1 = "$newfollow1 $newfollowPlatform1"
        Add-Content -Path $filePath -Value $line
        Write-Host "Who is the second person you want to add?"
        $newfollow2 = Read-Host
        if ($newfollow2 -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
        Write-Host "Where do they stream [TTV/YT]"
        $newfollowPlatform2 = Read-Host
        if ($newfollowPlatform2 -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
        $line2 = "$newfollow2 $newfollowPlatform2"
        Add-Content -Path $filePath -Value $line1
        Add-Content -Path $filePath -Value $line2
        Write-Host "Both $newfollow1 from $newfollowPlatform1 and $newfollow2 from $newfollowPlatform2 has been added"
    }
}

# Check if the list has only one entry
elseif ($lines.Count -eq 1) {Write-Host "Having one streamer in your follow list is currently disabled due to a powershell bug"
Write-Host "The current workaround is adding a 2nd streamer. Would you like to do that? [Y/N]"
$workaround = Read-Host
if ($workaround -eq "y") {
    Write-Host "Who is the first person you want to add?"
        $newfollow1 = Read-Host
        Write-Host "Where do they stream [TTV/YT]"
        $newfollowPlatform1 = Read-Host
        $line1 = "`n$newfollow1 $newfollowPlatform1"
        Add-Content -Path $filePath -Value $line1
        Write-Host "$newfollow1 from $newfollowPlatform1 has been added successfully"
}


    Pause
    if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
    exit
    }
else {
# Display the menu with numbered options
for ($i = 0; $i -lt $lines.Count; $i++) {
    $channel, $platform = $lines[$i] -split ' '
    Write-Host "$($i + 1). $channel"}

# Prompt the user to enter a number or "!"
Write-Host "Enter the number of the streamer you want to watch: " -NoNewline
$selection = Read-Host

# Check if the user input is "add"
if ($selection -eq "add") {
Write-Host "Who do you want to add?"
$newfollow = Read-Host
Write-Host "Where do they stream [TTV/YT]"
$newfollowPlatform = Read-Host
$line = "$newfollow $newfollowPlatform"
Add-Content -Path $filePath -Value $line
Write-Host "$newfollow from $newfollowPlatform has been added"
Write-Host "Head back to this menu to watch the person you just added"
Pause
if ($bat -eq "Y") {Start-Process "run.bat"}
if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
exit
}
# Check if the user input is "remove"
if ($selection -eq  "remove") {
    Write-Host "Enter the number of the streamer you want to delete: " -NoNewline
    $lineNumberToDelete = Read-Host
    $lines = Get-Content -Path $filePath

        # Convert the user's input to an integer
        $lineNumberToDelete = [int]$lineNumberToDelete

        # Validate the user's input
        if ($lineNumberToDelete -lt 1 -or $lineNumberToDelete -gt $lines.Count) {
            Write-Host "Invalid selection. Please choose a number between 1 and $($lines.Count)"
        }
        else {
            # Get the selected streamer based on the user's input
            $selectedLine = $lines[$lineNumberToDelete - 1]
            $channel, $platform = $selectedLine -split ' '
        }

    # Remove the desired line
    $lines = $lines | Where-Object { $_ -ne $lines[$lineNumberToDelete - 1] }


    # Write the modified contents back to the file
    $lines | Set-Content -Path $filePath

    Write-Host ""
    Write-Host "$channel has been deleted."
    Write-Host "Come back to this menu to view the new list."
    Pause
    if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
    exit
}
# Check if the user input is "!"
if ($selection -eq "!") {
    if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
    exit
}
else {
    # Convert the user's input to an integer
    $selection = [int]$selection

    # Validate the user's input
    if ($selection -lt 1 -or $selection -gt $lines.Count) {
        Write-Host "Invalid selection. Please choose a number between 1 and $($lines.Count)"
    }
    else {
        # Get the selected streamer based on the user's input
        $selectedLine = $lines[$selection - 1]
        $channel, $platform = $selectedLine -split ' '

        # Output the selected streamer
        Write-Host ""
        Write-Host "Selected Streamer:"
        Write-Host "Channel: $channel"
        Write-Host "Platform: $platform"
    }
}}

        if ($platform -eq "yt") {
            $handle = $channel
            $Splatform = "YT"
        $Splatform | Out-File -FilePath .\platform.txt
        $handle | Out-File -FilePath .\handle.txt
        $YTtoken = Get-Content "YTtoken.txt"
       # Set up your API key
$apiKey = $YTtoken

# Set the search query
$searchQuery = "@$handle"

# Create the base URL for the API request
$baseUrl = 'https://www.googleapis.com/youtube/v3/search'

# Construct the full URL with query parameters
$queryParams = @{
    'part' = 'snippet'
    'q' = $searchQuery
    'type' = 'channel'
    'key' = $apiKey
}
$urlParams = $queryParams.GetEnumerator() | ForEach-Object { $_.Key + '=' + $_.Value }
$url = $baseUrl + '?' + ($urlParams -join '&')

# Send the API request and retrieve the response
$response = Invoke-RestMethod -Uri $url

# Process the search results
$channels = $response.items
if ($channels.Count -gt 0) {
    $channel_id = $channels[0].id.channelId
}
        $channel_id | Out-File -FilePath .\channel_id.txt
        $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_id&eventType=live&type=video&key=$YTtoken"
        $response = Invoke-RestMethod -Uri $url -Method Get
        if($response.items.Count -gt 0){
            $live_stream = $response.items[0]
            $video_id = $live_stream.id.videoId
            $video_id | Out-File -FilePath .\video_id.txt
            $channel_id | Out-File -FilePath .\channel_id.txt
            if ($handle -eq "LofiGirl" -or $handle -eq "Pokemon") {
               $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_Id&type=video&eventType=live&key=$YTtoken"
               $response = Invoke-RestMethod $url
               $streams = $response.items
               Write-Host "Choose a live stream to watch:"
               for ($i = 1; $i -lt $streams.Count; $i++) {
                   Write-Host "$i. $($streams[$i].snippet.title)"
               }
               $selection = Read-Host "Enter the number of the live stream you want to watch"
               $snippetId = $streams[$selection].id.videoId
               $videoUrl = "https://www.youtube.com/embed/$snippetId"
               $chatUrl = "https://www.youtube.com/live_chat?v=$snippetId"
               $snippetId | Out-File .\video_id.txt
               switch -regex ($Browser) {
                   'Default' {
                       Start-Process $videoUrl"?&autoplay=1"
                       Start-Process $chatUrl
                       exit
                   }
                   'Chrome' {
                       Start-Process "chrome.exe" --app=$videoUrl"?&autoplay=1"
                       Start-Process "chrome.exe" --app=$chatUrl
                       exit
                   }
               }
           }
        
            if ($handle -eq "MattKC") {
                switch -regex ($Browser) {
                    'Default' {
                        Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                        Start-Process "https://stream.mattkc.com/chat/"
                        exit
                    }
                    'Chrome' {
                        Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                        Start-Process "chrome.exe" --app="https://stream.mattkc.com/chat/"
                        exit
                    }
                }
            }
            else {
                switch -regex ($Browser) {
                    'Default' {
                        Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                        Start-Process "https://www.youtube.com/live_chat?v=$video_id"
                        exit
                    }
                    'Chrome' {
                        Start-Process "chrome.exe" --app="https://www.youtube.com/live_chat?v=$video_id"
                        Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                        exit
                    }
                }
            }
        }
        else{
            # No live streams found, search for upcoming streams
            $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_id&eventType=upcoming&type=video&key=$YTtoken"
            $response = Invoke-RestMethod -Uri $url -Method Get
        
            if($response.items.Count -gt 0){
                # An upcoming live stream is found, open the chat in a new browser tab
                $upcoming_stream = $response.items[0]
                $video_id = $upcoming_stream.id.videoId
                $video_id | Out-File -FilePath .\video_id.txt
                $channel_id | Out-File -FilePath .\channel_id.txt
        
                switch -regex ($Browser) {
                    'Default' {
                        Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id"
                        Start-Process "https://www.youtube.com/live_chat?v=$video_id"
                        exit
                    }
                    'Chrome' {
                        Start-Process "chrome.exe" --app="https://www.youtube.com/live_chat?v=$video_id"
                        Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id"
                        exit
                    }
                }
            }
            if ($handle -eq "MattKC") {
               switch -regex ($Browser) {
                   'Default' {
                       Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                       Start-Process "https://stream.mattkc.com/chat/"
                       exit
                   }
                   'Chrome' {
                       Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                       Start-Process "chrome.exe" --app="https://stream.mattkc.com/chat/"
                       exit
                   }
               }
           }
       
           
           Write-Host "Error 404: YouTube live stream not found"
           $video_id = "no video id"
           $video_id | Out-File -FilePath .\video_id.txt
       $countdown = 5
       while ($countdown -gt 0) {
           Write-Host -NoNewline "This application will automatically restart in $countdown seconds..`r"
           Start-Sleep -Seconds 1
           $countdown--
       }
       $video_id = "no video id"
       $video_id | Out-File -FilePath .\video_id.txt
       if ($bat -eq "Y") {Start-Process "run.bat"}
                if ($null -eq $bat) {Clear-Host 
                Powershell -File "LiveStreamViewer.ps1"}
                exit
        }}

        if ($platform -eq "ttv") {
            Start-Sleep -Milliseconds 2000
            $TTVstreamer = $channel
            $Splatform = "TTV"
    $Splatform | Out-File -FilePath .\platform.txt
    $TTVstreamer | Out-File -FilePath .\streamer.txt

    if (Test-Path "Twitchclient_id.txt") {
        if (Test-Path "Twitchtoken.txt") {}
        else {Write-Host "VOD saving is disabled due to no access token." -ForegroundColor Red
        Write-Host "To enable it you need to go to the main menu and type"
        Write-Host "config -> ttv"
        Write-Host "and then follow the on-screen instructions to set it up"
        Start-Sleep -Milliseconds 4000}
    } else {Write-Host "VOD saving is disabled due to no client id & access token." -ForegroundColor Red
            Write-Host "To enable it you need to go to the main menu and type"
            Write-Host "config -> ttv"
            Write-Host "and then follow the on-screen instructions to set it up"
            Start-Sleep -Milliseconds 4000
        }
    $clientId = Get-Content "Twitchclient_id.txt" -ErrorAction SilentlyContinue
    $accessToken = Get-Content "Twitchtoken.txt" -ErrorAction SilentlyContinue
    $TTVstreamer = Get-Content "streamer.txt"
    
    # Convert streamer name to user ID
    $userIdUri = "https://api.twitch.tv/helix/users?login=$TTVstreamer"
    $userIdHeaders = @{
        "Client-ID" = $clientId
        "Authorization" = "Bearer $accessToken"
    }
    $ErrorActionPreference = "SilentlyContinue"
    $userIdResponse = Invoke-RestMethod -Uri $userIdUri -Headers $userIdHeaders -Method GET
    
    # Check if a user is found in the response
    if ($userIdResponse.data.Count -gt 0) {
        $userId = $userIdResponse.data[0].id
    
        # Get the most recent video using the user ID
        $videoUri = "https://api.twitch.tv/helix/videos?user_id=$userId&first=1&sort=time" 
        $videoHeaders = @{
            "Client-ID" = $clientId
            "Authorization" = "Bearer $accessToken"
        }
        $videoResponse = Invoke-RestMethod -Uri $videoUri -Headers $videoHeaders -Method GET -ErrorAction SilentlyContinue
    
        # Check if there are videos in the response
        if ($videoResponse.data.Count -gt 0) {
            $mostRecentVideoId = $videoResponse.data[0].id
            $mostRecentVideoId | Out-File "vod_id.txt"
        }
        else {
            "no vod" | Out-File "vod_id.txt"
        }
    }
    else {
        "no vod" | Out-File "vod_id.txt"
    }
    switch -regex ($Browser) {
       'Chrome' {Start-Process "chrome.exe" --app="https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
       Start-Process "chrome.exe" --app="https://www.twitch.tv/popout/$TTVstreamer/chat?popout="}
   
       'Default' {Start-Process "https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
       Start-Process "https://www.twitch.tv/popout/$TTVstreamer/chat?popout="}}
       exit
        }
    Pause
    exit
    }

    'help' {
        Clear-Host
        Write-Host "If you input a "-NoNewline
        Write-Host "!"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
        Write-Host " the program will go back to the previous screen"
        Write-Host "1: PLATFORM"
        Write-Host "2: OPTIONS"
        Write-Host "3: EXTRA FUNCTIONS"
        Write-Host "4: DEBUG"
        Write-Host ""
        Write-Host "Which category do you want to know more about"
        $help = Read-Host
        if ($help -eq '1') {
            Clear-Host
            Write-Host "PLATFORM"
            Write-Host ""
            Write-Host "YT - Watches a youtube streamer (requires api key)"
            Write-Host "TTV - Watces a streamer on twitch"
            Write-Host "HD - Opens HoloDex on multiview"
            Write-Host "kick - Currently unsupported"
            Write-Host ""
            Pause
            if ($bat -eq "Y") {Start-Process "run.bat"}
            if ($null -eq $bat) {Clear-Host 
            Powershell -File "LiveStreamViewer.ps1"}
            exit
            }
        if ($help -eq '2') {
            Clear-Host
            Write-Host "OPTIONS"
            Write-Host ""
            Write-Host "config - lets you reconfigure your YouTube API key. This key is saved to YTtoken.txt"
            Write-Host ""
            Pause
            if ($bat -eq "Y") {Start-Process "run.bat"}
            if ($null -eq $bat) {Clear-Host 
            Powershell -File "LiveStreamViewer.ps1"}
            exit
        }
        if ($help -eq '3') {
            Clear-Host
            Write-Host "EXTRA FUNCTIONS"
            Write-Host ""
            Write-Host "r/refresh/reload - Reloads to the previously watched stream based on various text files"
            Write-Host "followlist/follows - shows a list of the people you are following. You can input the number on the left side of their name and their stream should launch automatically"
            Pause
            if ($bat -eq "Y") {Start-Process "run.bat"}
            if ($null -eq $bat) {Clear-Host 
            Powershell -File "LiveStreamViewer.ps1"}
            exit
        }
        if ($help -eq '4') {
            Clear-Host
            Write-Host "DEBUG"
            Write-Host ""
            Write-Host "ytapi - shows your YouTube API key before YouTube loads"
            Write-Host "bat - shows if you have ran the application from the included batch file"
            Write-Host "var - Shows all of the saved variables"
            Write-Host ""
            Pause
            if ($bat -eq "Y") {Start-Process "run.bat"}
            if ($null -eq $bat) {Clear-Host 
            Powershell -File "LiveStreamViewer.ps1"}
            exit
        }
    }
    'update' {Clear-Host
       Powershell -File "update.ps1" $bat
        }
 'YT|yt' {
    Clear-Host
    $YTtoken = Get-Content "YTtoken.txt"
    Clear-Host
    Write-Host "The current platform is " -NoNewline
    Write-Host "YouTube" -ForegroundColor Red
    if ($null -eq $YTtoken) {Write-Host "YouTube API key has not been set" -BackgroundColor Red}
    if ($platform -eq "ytAPI" -eq "ytapi") {$YTtoken = Get-Content "YTtoken.txt"
    Write-Host "Your YouTube API key is $YTtoken"}
    Write-Host ""
 Write-Host "If you input a "-NoNewline
 Write-Host "!"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
 Write-Host " the program will go back to the previous screen"
 Write-Host "If you input a "-NoNewline
 Write-Host "?"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
 Write-Host " it will play the most recently played stream"
 Write-Host "If you input a "-NoNewline
 Write-Host "#"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
 Write-Host " it will play the vod of most recently played stream"
 Write-Host "What is the @handle of the YouTube streamer you are trying to watch?: @" -NoNewline
 $handle = Read-Host 

if ($handle -eq "!") {
if ($bat -eq "Y") {Start-Process "run.bat"}
if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
exit
}

if ($handle -eq "?") {
    $video_id = Get-Content "video_id.txt" -ErrorAction SilentlyContinue
    if ($null -eq $video_id) {
        Write-Host "There is no recent stream"
        Pause
        Write-Host "Restarting..."
        Start-Sleep -Milliseconds 2000
        if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit
    }
        $Splatform = "YT"
        $Splatform | Out-File -FilePath .\platform.txt
        $videoUrl = "https://www.youtube.com/embed/$video_id"
        $chatUrl = "https://www.youtube.com/live_chat?v=$video_id"
        switch -regex ($Browser) {
        'Default' {
            Start-Process $videoUrl"?&autoplay=1"
            Start-Process $chatUrl
            exit
        }
        'Chrome' {
            Start-Process "chrome.exe" --app=$videoUrl"?&autoplay=1"
            Start-Process "chrome.exe" --app=$chatUrl
            exit}}
        exit
}
 if ($handle -eq "#") {
    $video_id = Get-Content "video_id.txt" -ErrorAction SilentlyContinue
    if ($null -eq $video_id) {
        Write-Host "There is no recent stream"
        Pause
        Write-Host "Restarting..."
        Start-Sleep -Milliseconds 2000
        if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
    $vodUrl = "https://www.youtube.com/watch?v=$video_id"
    switch -regex ($Browser) {
        'Default' {
            Start-Process $vodUrl"?&autoplay=1"
            exit
        }
        'Chrome' {
            Start-Process "chrome.exe" --app=$vodUrl"?&autoplay=1"
            exit}}
        exit
}

 if ($null -eq $handle -or $handle -eq '' -or $handle -eq ' ' -or $handle -eq '  ' -or $handle -eq '   ') {Write-Host "A blank handle is invalid."
 $countdown = 10
 while ($countdown -gt 0) {
     Write-Host -NoNewline "This application will automatically close in $countdown seconds...`r"
     Start-Sleep -Seconds 1
     $countdown--
 }
 exit}

 $Splatform = "YT"
 $Splatform | Out-File -FilePath .\platform.txt
 $handle | Out-File -FilePath .\handle.txt
 $YTtoken = Get-Content "YTtoken.txt"
        # Set up your API key
$apiKey = $YTtoken

# Set the search query
$searchQuery = "@$handle"

# Create the base URL for the API request
$baseUrl = 'https://www.googleapis.com/youtube/v3/search'

# Construct the full URL with query parameters
$queryParams = @{
    'part' = 'snippet'
    'q' = $searchQuery
    'type' = 'channel'
    'key' = $apiKey
}
$urlParams = $queryParams.GetEnumerator() | ForEach-Object { $_.Key + '=' + $_.Value }
$url = $baseUrl + '?' + ($urlParams -join '&')

# Send the API request and retrieve the response
$response = Invoke-RestMethod -Uri $url

# Process the search results
$channels = $response.items
if ($channels.Count -gt 0) {
    $channel_id = $channels[0].id.channelId
}
 $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_id&eventType=live&type=video&key=$YTtoken"
 $response = Invoke-RestMethod -Uri $url -Method Get
 if($response.items.Count -gt 0){
     $live_stream = $response.items[0]
     $video_id = $live_stream.id.videoId
     $video_id | Out-File -FilePath .\video_id.txt
     $channel_id | Out-File -FilePath .\channel_id.txt
     if ($handle -eq "LofiGirl" -or $handle -eq "Pokemon") {
        $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_Id&type=video&eventType=live&key=$YTtoken"
        $response = Invoke-RestMethod $url
        $streams = $response.items
        Write-Host "Choose a live stream to watch:"
        for ($i = 0; $i -lt $streams.Count; $i++) {
            Write-Host "$i. $($streams[$i].snippet.title)"
        }
        $selection = Read-Host "Enter the number of the live stream you want to watch"
        $snippetId = $streams[$selection].id.videoId
        $videoUrl = "https://www.youtube.com/embed/$snippetId"
        $chatUrl = "https://www.youtube.com/live_chat?v=$snippetId"
        $snippetId | Out-File .\video_id.txt
        switch -regex ($Browser) {
            'Default' {
                Start-Process $videoUrl"?&autoplay=1"
                Start-Process $chatUrl
                exit
            }
            'Chrome' {
                Start-Process "chrome.exe" --app=$videoUrl"?&autoplay=1"
                Start-Process "chrome.exe" --app=$chatUrl
                exit
            }
        }
    }
 
     if ($handle -eq "MattKC") {
         switch -regex ($Browser) {
             'Default' {
                 Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                 Start-Process "https://stream.mattkc.com/chat/"
                 exit
             }
             'Chrome' {
                 Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                 Start-Process "chrome.exe" --app="https://stream.mattkc.com/chat/"
                 exit
             }
         }
     }
     else {
         switch -regex ($Browser) {
             'Default' {
                 Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                 Start-Process "https://www.youtube.com/live_chat?v=$video_id"
                 exit
             }
             'Chrome' {
                 Start-Process "chrome.exe" --app="https://www.youtube.com/live_chat?v=$video_id"
                 Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                 exit
             }
         }
     }
 }
 else{
     # No live streams found, search for upcoming streams
     $url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channel_id&eventType=upcoming&type=video&key=$YTtoken"
     $response = Invoke-RestMethod -Uri $url -Method Get
 
     if($response.items.Count -gt 0){
         # An upcoming live stream is found, open the chat in a new browser tab
         $upcoming_stream = $response.items[0]
         $video_id = $upcoming_stream.id.videoId
         $video_id | Out-File -FilePath .\video_id.txt
         $channel_id | Out-File -FilePath .\channel_id.txt
 
         switch -regex ($Browser) {
             'Default' {
                 Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id"
                 Start-Process "https://www.youtube.com/live_chat?v=$video_id"
                 exit
             }
             'Chrome' {
                 Start-Process "chrome.exe" --app="https://www.youtube.com/live_chat?v=$video_id"
                 Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id"
                 exit
             }
         }
     }
     if ($handle -eq "MattKC") {
        switch -regex ($Browser) {
            'Default' {
                Start-Process "https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                Start-Process "https://stream.mattkc.com/chat/"
                exit
            }
            'Chrome' {
                Start-Process "chrome.exe" --app="https://www.youtube.com/embed/live_stream?channel=$channel_id&autoplay=1"
                Start-Process "chrome.exe" --app="https://stream.mattkc.com/chat/"
                exit
            }
        }
    }

    
    Write-Host "Error 404: YouTube live stream not found"
    $video_id = "no video id"
    $video_id | Out-File -FilePath .\video_id.txt
$countdown = 5
while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will automatically restart in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
}
if ($bat -eq "Y") {Start-Process "run.bat"}
                if ($null -eq $bat) {Clear-Host 
                Powershell -File "LiveStreamViewer.ps1"}
                exit
 }
 }

    'Twitch|twitch|TTV|ttv|twitch.tv|justin.tv|jtv|JTV'{
    Clear-Host
    Write-Host "The current platform is " -NoNewline
    Write-Host "Twitch" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "If you input a "-NoNewline
    Write-Host "!"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
    Write-Host " the program will go back to the previous screen"
    Write-Host "If you input a "-NoNewline
    Write-Host "?"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
    Write-Host " it will play the the most recently played stream"
    Write-Host "If you input a "-NoNewline
    Write-Host "#"-NoNewline -ForegroundColor Black -BackgroundColor Yellow
    Write-Host " it will play the vod of the most recently played stream"


    Write-Host "Who do you want to watch on twitch?: " -NoNewline
    $TTVstreamer = Read-Host

    if ($TTVstreamer -eq "!") {
        if ($bat -eq "Y") {Start-Process "run.bat"}
        if ($null -eq $bat) {Clear-Host 
        Powershell -File "LiveStreamViewer.ps1"}
        exit}
    
        if ($TTVstreamer -eq "?") {
            $TTVstreamer = Get-Content "streamer.txt" -ErrorAction SilentlyContinue
            if ($null -eq $TTVstreamer) {
                Write-Host "There is no recent stream"
                Pause
                Write-Host "Restarting..."
                Start-Sleep -Milliseconds 2000
                if ($bat -eq "Y") {Start-Process "run.bat"}
                if ($null -eq $bat) {Clear-Host 
                Powershell -File "LiveStreamViewer.ps1"}
                exit
            }
            
            $Splatform = "TTV"
            $Splatform | Out-File -FilePath .\platform.txt
    switch -regex ($Browser) {
        'Chrome' {Start-Process "chrome.exe" --app="https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
        Start-Process "chrome.exe" --app="https://www.twitch.tv/popout/$TTVstreamer/chat?popout="
    exit}
    
        'Default' {Start-Process "https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
        Start-Process "https://www.twitch.tv/popout/$TTVstreamer/chat?popout="
    exit}}
        }
            if ($TTVstreamer -eq "#") {
                $mostRecentVideoId = Get-Content "vod_id.txt"
                if ($mostRecentVideoId -eq "no vod") {
                    Write-Host "There is no vod to watch"
                    Pause
                    if ($bat -eq "Y") {Start-Process "run.bat"}
                    if ($null -eq $bat) {Clear-Host 
                    Powershell -File "LiveStreamViewer.ps1"}
                    exit
                }
                switch -regex ($Browser) {
                    'Chrome' {Start-Process "chrome.exe" --app="https://www.twitch.tv/videos/$mostRecentVideoId"
                exit}
                
                    'Default' {Start-Process "https://www.twitch.tv/videos/$mostRecentVideoId"
                exit}}
            }
    if ($null -eq $TTVstreamer -or $TTVstreamer -eq '' -or $TTVstreamer -eq ' ' -or $TTVstreamer -eq '  ' -or $TTVstreamer -eq '   ') {Write-Host "A blank statement is invalid."
    $countdown = 10
    while ($countdown -gt 0) {
        Write-Host -NoNewline "This application will automatically close in $countdown seconds..`r"
        Start-Sleep -Seconds 1
        $countdown--
    }
    exit}
    $Splatform = "TTV"
    $Splatform | Out-File -FilePath .\platform.txt
    $TTVstreamer | Out-File -FilePath .\streamer.txt

    if (Test-Path "Twitchclient_id.txt") {
        if (Test-Path "Twitchtoken.txt") {}
        else {Write-Host "VOD saving is disabled due to no access token." -ForegroundColor Red
        Write-Host "To enable it you need to go to the main menu and type"
        Write-Host "config -> ttv"
        Write-Host "and then follow the on-screen instructions to set it up"
        Start-Sleep -Milliseconds 4000}
    } else {Write-Host "VOD saving is disabled due to no client id & access token." -ForegroundColor Red
            Write-Host "To enable it you need to go to the main menu and type"
            Write-Host "config -> ttv"
            Write-Host "and then follow the on-screen instructions to set it up"
            Start-Sleep -Milliseconds 4000
        }
    $clientId = Get-Content "Twitchclient_id.txt" -ErrorAction SilentlyContinue
    $accessToken = Get-Content "Twitchtoken.txt" -ErrorAction SilentlyContinue
    $TTVstreamer = Get-Content "streamer.txt"
    
    # Convert streamer name to user ID
    $userIdUri = "https://api.twitch.tv/helix/users?login=$TTVstreamer"
    $userIdHeaders = @{
        "Client-ID" = $clientId
        "Authorization" = "Bearer $accessToken"
    }
    $ErrorActionPreference = "SilentlyContinue"
    $userIdResponse = Invoke-RestMethod -Uri $userIdUri -Headers $userIdHeaders -Method GET
    
    # Check if a user is found in the response
    if ($userIdResponse.data.Count -gt 0) {
        $userId = $userIdResponse.data[0].id
    
        # Get the most recent video using the user ID
        $videoUri = "https://api.twitch.tv/helix/videos?user_id=$userId&first=1&sort=time" 
        $videoHeaders = @{
            "Client-ID" = $clientId
            "Authorization" = "Bearer $accessToken"
        }
        $videoResponse = Invoke-RestMethod -Uri $videoUri -Headers $videoHeaders -Method GET -ErrorAction SilentlyContinue
    
        # Check if there are videos in the response
        if ($videoResponse.data.Count -gt 0) {
            $mostRecentVideoId = $videoResponse.data[0].id
            $mostRecentVideoId | Out-File "vod_id.txt"
        }
        else {
            "no vod" | Out-File "vod_id.txt"
        }
    }
    else {
        "no vod" | Out-File "vod_id.txt"
    }
    switch -regex ($Browser) {
       'Chrome' {Start-Process "chrome.exe" --app="https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
       Start-Process "chrome.exe" --app="https://www.twitch.tv/popout/$TTVstreamer/chat?popout="}
   
       'Default' {Start-Process "https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
       Start-Process "https://www.twitch.tv/popout/$TTVstreamer/chat?popout="}}
       exit
    }

    'HoloDex|holodex|HD|hd' {
        $Splatform = "HD"
        $Splatform | Out-File -FilePath .\platform.txt
            switch -regex ($Browser) {
       'Chrome' {Start-Process "chrome.exe" --app="https://holodex.net/multiview"}
   
       'Default' {Start-Process "https://holodex.net/multiview"}}
       exit
    }
    'ChatGPT|GPT' {Write-Host "The following code was written by Open AI's Chat GPT"
    Write-Host "Would you like to continue? [Y/N]"
    $GPTstart = Read-Host
    switch -regex ($GPTstart) {
        'Y|yes' {
# Define the API endpoint
$url = "https://icanhazdadjoke.com/"

# Define the headers for the API request
$headers = @{
    "Accept" = "application/json"
    "User-Agent" = "PowerShell"
}

# Send the API request and get the response
$response = Invoke-RestMethod -Uri $url -Headers $headers

# Extract the joke text from the response
$joke = $response.joke

# Display the joke in the console
Write-Host ""
Write-Host "Here is a dad joke"
Write-Host "$joke"

# Start a countdown timer for 10 seconds
$countdown = 10
while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will close in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
}
Write-Host ""
exit}
'N|no'{Write-Host "Press any key to quit"
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

if ($Host.UI.RawUI.KeyAvailable) {
    # User pressed a key, so exit the script
    Write-Host "Quitting..."
    Start-Sleep -Seconds 2
    exit
} else {
    # User didn't press any key, so exit the script
    Write-Host "Quitting..."
    Start-Sleep -Seconds 2
    exit
}}
}
 }
 'config' {Clear-Host
    $YTtoken = Get-Content "YTtoken.txt" -ErrorAction SilentlyContinue
    $client_id = Get-Content "Twitchclient_id.txt" -ErrorAction SilentlyContinue
    $accessToken = Get-Content "Twitchtoken.txt" -ErrorAction SilentlyContinue
    Write-Host "Do you want to reconfigure Twitch or YouTube API? [TTV/YT]"
    $config = Read-Host
    if ($config -eq 'TTV') {
    Clear-Host
    Write-Host "You are currently reconfiguring " -NoNewline
    Write-Host "Twitch" -f Magenta
    Write-Host "You can input " -NoNewline
    Write-Host "!" -f Black -BackgroundColor Yellow -NoNewline
    Write-Host " to restart the application."
    Write-Host ""
    if ($null -eq $client_id) {Write-Host "client id is not configured" -ForegroundColor Red} else {
    Write-Host "Your current client id is $client_id"}
    if ($null -eq $accessToken) {Write-Host "access token is not configured" -ForegroundColor Red} else {
    Write-Host "Your current access token is $accessToken"}
    Write-Host ""
    Write-Host "Go to " -NoNewline
    Write-Host "https://twitchtokengenerator.com" -ForegroundColor Blue
    Write-Host "scroll down until you see 'Generate Token!'"
    Write-Host "Once you see it click it and log in with your twitch"
    Write-Host "When you have logged in to your twitch click on 'Authorize'"
    Write-Host "Then it should redirect you back to the site"
    Write-Host "Next do the 'I am not a robot captha'"
    Write-Host "Then you should see both 'ACCESS TOKEN' and 'CLIENT ID' filled out on the site"
    Write-Host "Frist click 'Copy' next to 'ACCESS TOKEN' and paste it here: "-NoNewline
    $accessToken = Read-Host
    if ($accessToken -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
    exit}
    Write-Host "Then click on 'Copy' next to 'CLIENT ID' and paste it in here: "-NoNewline
    $clientId = Read-Host
    if ($clientId -eq "!") {if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
    exit}
    Write-Host "You are now finished with the twitch vod reconfig."
    $accessToken | Out-File .\Twitchtoken.txt
    $clientId | Out-File .\Twitchclient_id.txt
    Pause
    if ($bat -eq "Y") {Start-Process "run.bat"}
    if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}}

    if ($config -eq 'YT') {
 Clear-Host
 Write-Host "You are configuring YouTube"
 Write-Host ""
 Write-Host "Your current YouTube API key is $YTtoken." 
Write-Host "Would you like to reconfigure it? [Y/N]"
 $anwser=Read-Host
 switch -regex ($anwser) {
    'y' {
        Clear-Host
        Write-Host "What is your YouTube API key?"
        Write-Host "If you don't know how to get it you can read this offical tutorial"
        Write-Host "https://developers.google.com/youtube/v3/getting-started" -ForegroundColor Blue
        Write-Host "Once you are done come back and paste it here: " -NoNewline
        $NewYTapi = Read-Host
        Write-Host ""
        Write-Host "$NewYTapi"
        Write-Host "Are you sure this is correct? [Y/N]"
        $YTapiCONF = Read-Host
             switch -regex ($YTapiCONF) {
                'Y|y' {Write-Host "Making file..."
                $NewYTapi | Out-File -FilePath .\YTtoken.txt
                Write-Host "File has been made"
                Write-Host "Press any key to return to the home menu"
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                
                if ($Host.UI.RawUI.KeyAvailable) {
                    if ($bat -eq "Y") {Start-Process "run.bat"}
                    if ($null -eq $bat) {Clear-Host 
                        Powershell -File "LiveStreamViewer.ps1"}
                        exit
                } else {
                    if ($bat -eq "Y") {Start-Process "run.bat"}
                    if ($null -eq $bat) {Clear-Host 
                        Powershell -File "LiveStreamViewer.ps1"}
                        exit
                }}
                'N|n' {Write-Host "Not making file and finishing setup..."}
            }
    }
    'N|n' {
        Write-Host "Returning back to the prevoius menu..."
        Start-Sleep -Seconds 2
        if ($bat -eq "Y") {Start-Process "run.bat"}
if ($null -eq $bat) {Clear-Host 
    Powershell -File "LiveStreamViewer.ps1"}
exit
    exit}}
 }}
 

'kick|kick.com|k' {
    Write-Host "kick is currently not supported because popout video is unsupported"
$countdown = 10
while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will automatically close in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
}
exit
}
'changelog|log' {
    Clear-Host
    Write-Host "Changes for Release 1.0"
    Write-Host ""
    Write-Host "Devloper's notes"
    Write-Host "After a long devlopment period of 5 months I am proud to release 1.0 of this application."
    Write-Host ""
    Write-Host "KNOWN BUGS"
    Write-Host "Invalid prompt timer will sometimes duplicate"
    Write-Host ""
    Pause
    $countdown = 10
    while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will automatically close in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
    }
    exit
    }
'bat' {
if ($bat -eq "Y") {Write-Host "You are running this from the included batch file."}
if ($null -eq $bat) {Write-Host "You are running this from powershell"}
$countdown = 10
while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will automatically close in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
}
exit
}

 'reload|refresh|r' {$Splatform = Get-Content "platform.txt"
 switch -regex ($Splatform) {
    'YT' {
    $video_id = Get-Content "video_id.txt"
        $videoUrl = "https://www.youtube.com/embed/$video_id"
        $chatUrl = "https://www.youtube.com/live_chat?v=$video_id"
        switch -regex ($Browser) {
        'Default' {
            Start-Process $videoUrl"?&autoplay=1"
            Start-Process $chatUrl
            exit
        }
        'Chrome' {
            Start-Process "chrome.exe" --app=$videoUrl"?&autoplay=1"
            Start-Process "chrome.exe" --app=$chatUrl
            exit}}
        exit
}
    'TTV' {$TTVstreamer = Get-Content "streamer.txt"
    switch -regex ($Browser) {
        'Chrome' {Start-Process "chrome.exe" --app="https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
        Start-Process "chrome.exe" --app="https://www.twitch.tv/popout/$TTVstreamer/chat?popout="
    exit}
    
        'Default' {Start-Process "https://player.twitch.tv/?channel=$TTVstreamer&enableExtensions=true&muted=false&parent=twitch.tv&player=popout&quality=chunked&volume=1"
        Start-Process "https://www.twitch.tv/popout/$TTVstreamer/chat?popout="
    exit}}}
    'HD' {switch -regex ($Browser) {
        'Chrome' {Start-Process "chrome.exe" --app="https://holodex.net/multiview"}
    
        'Default' {Start-Process "https://holodex.net/multiview"}}
        exit}
 }
 }
}
 

Write-Host "Invalid Prompt"
$countdown = 5
while ($countdown -gt 0) {
    Write-Host -NoNewline "This application will automatically close in $countdown seconds..`r"
    Start-Sleep -Seconds 1
    $countdown--
}
exit
