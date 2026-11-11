REM @echo off
REM Repairs network connections. Based on:
REM http://www.windowsitsecurity.com/article/articleid/97605/repair-network-connections-from-the-command-line.html
REM http://support.microsoft.com/kb/289256
REM ############################################################

if /I not %USERNAME% == Administrator goto NOT_ADMIN
set outputdir=%~dp0
echo %SystemDrive%\TEMP\
set outputdir=%HOMEDRIVE%\TEMP\
set output=%outputdir%log.txt

echo. >> %output%
echo %time%: Beginning network repair process. >> %output%
echo. >> %output%

echo %time%: Renewing DHCP lease(s)... >> %output%
ipconfig /renew >> %output%
echo. >> %output%

echo %time%: Flushing ARP cache... >> %output%
arp -d * >> %output%
echo. >> %output%

echo %time%: Purging NBT remote cache table... >> %output%
nbtstat -R | find /i "failed"  >> %output%
echo %time%: Releasing and refreshing registered NBT names... >> %output% 
nbtstat -RR | find /i "failed" >> %output%
echo. >> %output%

echo %time%: Flushing DNS cache... >> %output%
ipconfig /flushdns >> %output%
echo %time%: Registering with DNS... >> %output%
ipconfig /registerdns >> %output%
echo %time%: Network repair process done. >> %output%

start %outputdir%
exit

:NOT_ADMIN
runas /user:Administrator %~f0
exit

REM ############################################################
REM @echo off
REM echo %time%: Beginning network repair process.
REM REM echo %time%: Releasing DHCP lease(s)...
REM REM ipconfig /release > NUL
REM echo %time%: Renewing DHCP lease(s)...
REM ipconfig /renew > NUL
REM echo %time%: Flushing ARP cache...
REM arp -d * > NUL
REM echo %time%: Purging NBT remote cache table....
REM nbtstat -R | find /i "failed" 1>&2
REM echo %time%: Releasing and refreshing registered NBT names...
REM nbtstat -RR | find /i "failed" 1>&2
REM echo %time%: Flushing DNS cache...
REM ipconfig /flushdns > NUL
REM echo %time%: Registering with DNS...
REM ipconfig /registerdns > NUL
REM echo %time%: Network repair process done.
REM ############################################################

