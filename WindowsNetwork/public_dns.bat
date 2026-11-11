@echo off

set "INTERFACE=singbox_tun"

netsh interface ip set dns name="%INTERFACE%" static 8.8.8.8
netsh interface ip add dns name="%INTERFACE%" 8.8.4.4 index=2
netsh interface ip add dns name="%INTERFACE%" 1.1.1.1 index=3

netsh interface ipv4 show dnsservers "%INTERFACE%" 

ipconfig /flushdns
