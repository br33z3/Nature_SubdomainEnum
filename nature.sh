#!/bin/bash

echo "   															  "
echo "                                                                                                                             "
echo -e " \e[32m NNNNNNNN        NNNNNNNN                           tttt                                                                   "
echo -e " \e[32m N:::::::N       N::::::N                        ttt:::t                                                                    "
echo -e " \e[32m N::::::::N      N::::::N                        t:::::t                                                                    "
echo -e " \e[32m N:::::::::N     N::::::N                        t:::::t                                                                    "
echo -e " \e[32m N::::::::::N    N::::::N  aaaaaaaaaaaaa   ttttttt:::::ttttttt    uuuuuu    uuuuuu  rrrrr   rrrrrrrrr       eeeeeeeeeeee    "
echo -e " \e[32m N:::::::::::N   N::::::N  a::::::::::::a  t:::::::::::::::::t    u::::u    u::::u  r::::rrr:::::::::r    ee::::::::::::ee  "
echo -e " \e[32m N:::::::N::::N  N::::::N  aaaaaaaaa:::::a t:::::::::::::::::t    u::::u    u::::u  r:::::::::::::::::r  e::::::eeeee:::::ee"
echo -e " \e[32m N::::::N N::::N N::::::N           a::::a tttttt:::::::tttttt    u::::u    u::::u  rr::::::rrrrr::::::re::::::e     e:::::e"
echo -e " \e[32m N::::::N  N::::N:::::::N    aaaaaaa:::::a       t:::::t          u::::u    u::::u   r:::::r     r:::::re:::::::eeeee::::::e"
echo -e " \e[32m N::::::N   N:::::::::::N  aa::::::::::::a       t:::::t          u::::u    u::::u   r:::::r     rrrrrrre:::::::::::::::::e "
echo -e " \e[32m N::::::N    N::::::::::N a::::aaaa::::::a       t:::::t          u::::u    u::::u   r:::::r            e::::::eeeeeeeeeee  "
echo -e " \e[32m N::::::N     N:::::::::Na::::a    a:::::a       t:::::t    ttttttu:::::uuuu:::::u   r:::::r            e:::::::e           "
echo -e " \e[32m N::::::N      N::::::::Na::::a    a:::::a       t::::::tttt:::::tu:::::::::::::::uu r:::::r            e::::::::e          "
echo -e " \e[32m N::::::N       N:::::::Na:::::aaaa::::::a       tt::::::::::::::t u:::::::::::::::u r:::::r             e::::::::eeeeeeee  "
echo -e " \e[32m N::::::N        N::::::N a::::::::::aa:::a        tt:::::::::::tt  uu::::::::uu:::u r:::::r              ee:::::::::::::e  "
echo -e " \e[32m NNNNNNNN         NNNNNNN  aaaaaaaaaa  aaaa          ttttttttttt      uuuuuuuu  uuuu rrrrrrr                eeeeeeeeeeeeee  "
echo -e "                                                                                                                             "
echo -e "                                                                                                                      \e[31m v0.01"
echo -e "														    \e[31mby br33z3"
echo -e "									   \e[31mIn-depth Subdomain Enumeration with Combined Tools"
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

chars="/-\|"
target=$1
rootdirectory=$PWD
aquatonedirectory="/root/aquatone/"${target}"/hosts.txt"
outputdirectory=${rootdirectory}"/"${target}
sublister_output=${outputdirectory}"/sublister_result"
amass_output=${outputdirectory}"/amass_result"
subfinder_output=${outputdirectory}"/subfinder_result"
aquatone_output=${outputdirectory}"/aquatone_result"

if [[ -n "$target" ]]; then

### Sublist3r Function Area ###
	printf '\n\n'
	mkdir $target 2>/dev/null
	echo -e "\e[33m[+] Folder Created..."
	echo "[+] Sublist3r Started..."
	spinner &
	SPIN_PID=$!
#	sublist3r -d $target -o sublister_result > /dev/null
	printf '\n'
	echo "[+] Sublist3r Finished..."
#	mv sublister_result $sublister_output
	echo "[+] Result Saved Successfully..."

### amass Function Area ###
	echo "[+] Amass Started..."
#	amass enum -d $target -silent -o amass_result
	printf '\n'
	echo "[+] Amass Finished..."
#	mv amass_result $amass_output
	echo "[+] Result Saved Successfully..."

### subfinder Function Area ###
	printf '\n'
	echo "[+] Subfinder Started..."
#	subfinder -d $target -o subfinder_result -silent > /dev/null
	echo "[+] Subfinder Finished..."
#	mv subfinder_result $subfinder_output
	echo "[+] Result Saved Successfully..."

### aquatone Function Area ###
	printf '\n'
	echo "[+] Aquatone Started..."
	echo "[!!!] This may take a while DO NOT EXIT..."
#	aquatone-discover -d $target --threads 30
	echo "[+] Aquatone Finished..."
#	mv $aquatonedirectory $aquatone_output
	echo "[+] Result Saved Successfully..."

### Extract Unique Subdomains Area ###
	printf '\n'
	echo "[+] Extracting Unique Subdomains..."
	cat $target/sublister_result > $target/bulkdomain
	cat $target/subfinder_result >> $target/bulkdomain
	cat $target/amass_result >> $target/bulkdomain
	cat $target/aquatone_result | cut -d "," -f 1 >> $target/bulkdomain
	sort -u $target/bulkdomain > $target/alluniquedomains
	echo "[+] Extracted Unique Subdomains..."
	echo "[+] Starting Reverse-IP Search..."
	cat $target/alluniquedomains | while read line; do host $line 2>/dev/null; done | grep address > $target/tmp
	cat $target/tmp | cut -d " " -f 4 | sort -u > $target/ipaddresses
	rm  $target/tmp
	cat $target/alluniquedomains > $target/everything
	cat $target/ipaddresses >> $target/everything
	rm  $target/sublister_result
	rm  $target/subfinder_result
	rm  $target/amass_result
	rm  $target/aquatone_result
	rm  $target/bulkdomain
	echo "[+] Reverse-IP Search Finished..."
	echo "[!!!] Exported All Files Inside $outputdirectory..."
	echo "[+++] Starting Port Scan For All Scope..."
	sleep 5
	cat $target/everything|aquatone -ports large -scan-timeout 5000 -http-timeout 10000 -threads 30 -out $target/aquatone

### Extract Unique Subdomains Area ###

else
	echo "Please Specify Target Domain"
	echo "Usage $0 <domain>"
fi





### finish the spinner process in the end ###
kill -9 $SPIN_PID 2>/dev/null


