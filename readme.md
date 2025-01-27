```bash
# getting current .sk domain list
curl -s https://www.sk-nic.sk/subory/domains.txt | grep '.sk;' | cut -f 1 -d ';' > domains.txt

# finding all domains with tenant
tools/azhunt -l domains.txt -tenant -j -o azhunt.txt

# go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
tools/subfinder -dL 0_domains.txt -all -o 1_tmp.txt
cat 0_domains.txt 1_tmp.txt | sort -u > 1_subdomains.txt ; rm 1_tmp.txt

# go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
export PDCP_API_KEY=XXX
tools/dnsx -l 1_subdomains.txt -o 2_tmp.txt -a -ro -asn -cdn -rl 2
cat 2_tmp.txt | sort -u > 2_ips_asns.txt ; rm 2_tmp.txt
cat 2_ips_asns.txt | cut -f 1 -d ' ' > 2_ips.txt

# go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
tools/naabu -l 2_ips.txt -o 3_ports.txt -passive
tools/naabu -l 2_ips.txt -o 3_ports.txt -Pn -tp 1000 

cat 3_ports.txt | cut -f 2 -d : | sort -u

# go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
tools/httpx -nc -l 1_subdomains.txt -o 4_httpx.txt -status-code -location -title -td -p XXX
cat 4_httpx.txt | cut -f 1 -d ' ' | sort -u > 4_urls.txt

# go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
tools/nuclei -l 4_urls.txt -o 5_nuclei_raw.txt --stats
cat 5_nuclei_raw.txt | sort -u > 5_nuclei.txt ; rm 7_nuclei_raw.txt

wpscan --api-token XXX --stealthy --url example.com
wpscan --api-token XXX --random-user-agent -t 2 --enumerate --url example.com

https://github.com/sqlmapproject/sqlmap
https://github.com/r0oth3x49/ghauri

# https://github.com/rbsec/dnscan
python3 dnscan.py -d example.com -w subdomains-100.txt

# https://github.com/MattKeeley/Spoofy
python3 spoofy.py -o stdout -d example.com

# https://github.com/m8sec/pymeta
python3 pymeta.py -d example.com

# https://aadinternals.com/osint/
Import-Module AADInternals
Invoke-AADIntReconAsOutsider -domainname example.com | ft
```
