#!/bin/bash

echo "   															  "
echo "                                                                                                                             "
echo "  NNNNNNNN        NNNNNNNN                           tttt                                                                   "
echo "  N:::::::N       N::::::N                        ttt:::t                                                                    "
echo "  N::::::::N      N::::::N                        t:::::t                                                                    "
echo "  N:::::::::N     N::::::N                        t:::::t                                                                    "
echo "  N::::::::::N    N::::::N  aaaaaaaaaaaaa   ttttttt:::::ttttttt    uuuuuu    uuuuuu  rrrrr   rrrrrrrrr       eeeeeeeeeeee    "
echo "  N:::::::::::N   N::::::N  a::::::::::::a  t:::::::::::::::::t    u::::u    u::::u  r::::rrr:::::::::r    ee::::::::::::ee  "
echo "  N:::::::N::::N  N::::::N  aaaaaaaaa:::::a t:::::::::::::::::t    u::::u    u::::u  r:::::::::::::::::r  e::::::eeeee:::::ee"
echo "  N::::::N N::::N N::::::N           a::::a tttttt:::::::tttttt    u::::u    u::::u  rr::::::rrrrr::::::re::::::e     e:::::e"
echo "  N::::::N  N::::N:::::::N    aaaaaaa:::::a       t:::::t          u::::u    u::::u   r:::::r     r:::::re:::::::eeeee::::::e"
echo "  N::::::N   N:::::::::::N  aa::::::::::::a       t:::::t          u::::u    u::::u   r:::::r     rrrrrrre:::::::::::::::::e "
echo "  N::::::N    N::::::::::N a::::aaaa::::::a       t:::::t          u::::u    u::::u   r:::::r            e::::::eeeeeeeeeee  "
echo "  N::::::N     N:::::::::Na::::a    a:::::a       t:::::t    ttttttu:::::uuuu:::::u   r:::::r            e:::::::e           "
echo "  N::::::N      N::::::::Na::::a    a:::::a       t::::::tttt:::::tu:::::::::::::::uu r:::::r            e::::::::e          "
echo "  N::::::N       N:::::::Na:::::aaaa::::::a       tt::::::::::::::t u:::::::::::::::u r:::::r             e::::::::eeeeeeee  "
echo "  N::::::N        N::::::N a::::::::::aa:::a        tt:::::::::::tt  uu::::::::uu:::u r:::::r              ee:::::::::::::e  "
echo "  NNNNNNNN         NNNNNNN  aaaaaaaaaa  aaaa          ttttttttttt      uuuuuuuu  uuuu rrrrrrr                eeeeeeeeeeeeee  "
echo "                                                                                                                             "
echo "                                                                                                                 	      v0.01"
echo "															  by br33z3"
echo "										 In-depth Subdomain Enumeration with Combined Tools"
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.5; do
        printf "%s\b"".""${sp:i++%n:1}"
    done
}

chars="/-\|"
target=$1
rootdirectory=$PWD
outputdirectory=${rootdirectory}"/"${target}
sublister_output=${outputdirectory}"/sublister_result"

if [[ -n "$target" ]]; then

### Sublist3r Function Area ###
	printf '\n\n'
	mkdir $target 2>/dev/null
	echo "[+] Folder Created..."
	echo "[+] Sublist3r Started..."
	spinner &
	SPIN_PID=$!
	sublist3r -d $target -o sublister_result > /dev/null
	printf '\n'
	echo "[+] Sublist3r Finished..."
	mv sublister_result $sublister_output
	echo "[+] Result Saved Successfully..."
###

### amass Function Area ###

	echo "[+] Amass Started..."



else
	echo "Please Specify Target Domain"
	echo "Usage $0 <domain>"
fi





### finish the spinner process in the end ###
kill -9 $SPIN_PID 2>/dev/null


