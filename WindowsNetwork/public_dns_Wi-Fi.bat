@echo off

set "INTERFACE=Wi-Fi"

netsh interface ip set dns name="%INTERFACE%" static 1.1.1.1
netsh interface ip add dns name="%INTERFACE%" 1.0.0.1 index=2
netsh interface ip add dns name="%INTERFACE%" 8.8.4.4 index=3
netsh interface ip add dns name="%INTERFACE%" 8.8.8.8 index=4

netsh interface ipv4 show dnsservers "%INTERFACE%" 

ipconfig /flushdns
