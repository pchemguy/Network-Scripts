@echo off

netsh interface ipv4 set dnsservers "Wi-Fi" source=DHCP
netsh interface ipv4 show dnsservers "Wi-Fi" 

ipconfig /flushdns
