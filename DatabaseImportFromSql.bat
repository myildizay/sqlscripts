echo off
sqlcmd -S ISTW10013 -d IQVIA_DASHBOARD -i C:\DbScripts\IQVIA_DASHBOARD.sql -U sa -P sakar81!
set /p delExit=Press the ENTER key to exit...: