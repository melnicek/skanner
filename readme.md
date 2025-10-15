```bash
tools/subfinder -dL 00-domains.txt -o 01-subfinder.txt -all
cat 00-domains.txt 01-subfinder.txt | sort -u > 01-subdomains.txt
tools/naabu -l 01-subdomains.txt -o 02-ports.txt
tools/httpx -l 02-ports.txt -o 03-httpx.txt -status-code -location -title -td -server
cat 03-httpx.txt | cut -f 1 -d ' ' > 04-urls.txt
# tools/nuclei -l 04-urls.txt -o 05-nuclei-kev.txt -mhe 0 -stats -tags kev
tools/nuclei -l 04-urls.txt -o 05-nuclei.txt -mhe 0 -stats -s critical,high,medium,low
```
