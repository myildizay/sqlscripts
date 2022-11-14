echo off
sqlcmd -S ISTW0160 -d ANKET -i C:\script.sql -U sa -P sakar81!
set /p delExit=Press the ENTER key to exit...: