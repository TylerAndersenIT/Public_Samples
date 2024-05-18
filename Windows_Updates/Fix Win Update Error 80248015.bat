color 0A
@echo off
cls
Echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Echo ~                                                                ~
Echo ~  Please wait while this script runs on account %username%...   ~
Echo ~                                                                ~  
Echo ~ Once this script finishes this window will automatically close ~
Echo ~                                                                ~
Echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Echo ~ Author: Tyler Andersen ~
Echo ~ Date:   12/4/2017      ~
Echo ~~~~~~~~~~~~~~~~~~~~~~~~~~


net stop WuAuServ
cd %windir%
rename "SoftwareDistribution" "SD_Old"
net start WuAuServ

Echo This window will close in a few seconds...
ping 127.0.0.1 -n 3 > nul