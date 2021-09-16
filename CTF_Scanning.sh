#!/bin/bash

#Made by Simon Tröster
#Blog: www.cybersimon.de
#Instagram: cybersimon.officially
#Version 1.0
#Disclaimer: Never use this script against any target without explicit permission! Everyone is responsible for 	
#	what they do with this script.

#Requirements: 
#	nmap
#	dirb
#	gobuster / and /usr/share/wordlists/dirb/common.txt 

#Expalanation:
#	The script starts with performing three NMAP scans at first it scans the first 1000 Ports. In the second 
#	scan, it scans every Port. And in the last scan, it performs a Vulnerability scan. After the NMAP Scans it 
#	performs a gobuster and a dirb scan.
#	If you dont want all scans than you can comment out the ones you dont want.

IP="10.10.10.10" 	#Enter Target IP
Name="Test"   		#Enter Name for your Output Data
echo Starting Scan on $IP


nmap -A $IP -oN All$Name.txt

sleep 5

nmap -p- $IP -oN Full$Name.txt

sleep 5

nmap --script vuln $IP -oN Vuln$Name.txt

sleep 5

gobuster dir -u http://$IP -w /usr/share/wordlists/dirb/common.txt -x php,txt,old,bak -o Gobuster$Name.txt 

sleep 5

dirb http://$IP -X .html,.php,.old,.bak -o dirbScan$Name.txt   

echo "Finished!"