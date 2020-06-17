# Nature_SubdomainEnumeration
In-depth Subdomain Enumeration with Combined Tools

</br>Simple script  for crawling **.onion** sites.</br>
Crawl pages and find href links.</br>
Follow links and crawl recursively.</br>
Delete duplicate links in the end and show final result.</br></br>

#### Install Requirements
`apt-get install sublist3r` Install Sublist3r
<br>`apt-get install amass` Install Amass
<br>`gem install aquatone`  Install Aquatone
<br>`apt-get install golang` Install Golang for Subfinder
<br>`GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/cmd/subfinder` Install Subfinder

#### Prerequisites
Change <.onion site> parts from the code to a valid onion site that you want to crawling</br>

#### Usage
chmod +x nature.sh
./nature.sh
<br><domain>
