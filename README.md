# Automated-Video-Downloader-PS
A PowerShell Script that uses youtube-dl to automate downloading multiple files

The script requires youtube-dl before it can be used. Youtube-dl by itself is 
a very powerful tool that can used to download online videos from almost anywhere.
This script is used to automate downloading many videos. Just put the URLs in
the input.txt file (each on it's own line), and the run the script. 
AVD will download each video one at a time at a 45 minute interval
(so network resources won't be clogged up). The downloaded files will end up
in whatever folder the script is located when it runs.
