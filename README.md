## Linux Computer Info script

Linux script

<!-- buttons -->
[![Stars](https://img.shields.io/github/stars/ivancarlosti/lnxcomputerinfo?label=⭐%20Stars&color=gold&style=flat)](https://github.com/ivancarlosti/lnxcomputerinfo/stargazers)
[![Watchers](https://img.shields.io/github/watchers/ivancarlosti/lnxcomputerinfo?label=Watchers&style=flat&color=red)](https://github.com/sponsors/ivancarlosti)
[![Forks](https://img.shields.io/github/forks/ivancarlosti/lnxcomputerinfo?label=Forks&style=flat&color=ff69b4)](https://github.com/sponsors/ivancarlosti)
[![Downloads](https://img.shields.io/github/downloads/ivancarlosti/lnxcomputerinfo/total?label=Downloads&color=success)](https://github.com/ivancarlosti/lnxcomputerinfo/releases)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/ivancarlosti/lnxcomputerinfo?label=Activity)](https://github.com/ivancarlosti/lnxcomputerinfo/pulse)  
[![GitHub Issues](https://img.shields.io/github/issues/ivancarlosti/lnxcomputerinfo?label=Issues&color=orange)](https://github.com/ivancarlosti/lnxcomputerinfo/issues)
[![License](https://img.shields.io/github/license/ivancarlosti/lnxcomputerinfo?label=License)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/ivancarlosti/lnxcomputerinfo?label=Last%20Commit)](https://github.com/ivancarlosti/lnxcomputerinfo/commits)
[![Security](https://img.shields.io/badge/Security-View%20Here-purple)](https://github.com/ivancarlosti/lnxcomputerinfo/security)  
[![Code of Conduct](https://img.shields.io/badge/Code%20of%20Conduct-2.1-4baaaa)](https://github.com/ivancarlosti/lnxcomputerinfo?tab=coc-ov-file)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/ivancarlosti?label=GitHub%20Sponsors&color=ffc0cb)][sponsor]
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00)][buymeacoffee]
[![Patreon](https://img.shields.io/badge/Patreon-f96854)][patreon]
<!-- endbuttons -->

Copy and run on shell, no privileged access required.

```
clear && \
echo "############################ SYSTEM INFORMATION ############################" && \
echo "" && \
# Operating System info
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')" && \
echo "Kernel: $(uname -r)" && \
echo "" && \
# CPU cores count
echo "Processor:" && \
echo "CPU vCores: $(nproc)" && \
# CPU usage with availability
echo "CPU Consumption: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "Usage "100 - $1 "%, Available " $1 "%"}')" && \
echo "" && \
# Memory detailed output
free -m | awk '
NR==1{print "Memory Consumption:"}
NR==2{
  total=$2; used=$3; free=$4; buff_cache=$6;
  usage_perc=(used/total)*100;
  buffcache_perc=(buff_cache/total)*100;
  available_perc=(free/total)*100;
  printf "Total %dM, Used %dM, Buffers/Cache %dM, Free %dM\nUsage %.1f%%, Buffers/Cache %.1f%%, Available %.1f%%\n",
         total, used, buff_cache, free, usage_perc, buffcache_perc, available_perc;
}' && \
echo "" && \
# Disk usage with total and per mount including usage percentage and available
df -h --total | awk 'NR==1{print "Disk Consumption:"} NR>1 && $1=="total"{usage_num=substr($5,1,length($5)-1); printf "Total %s, Used %s, Free %s, Usage %s, Available %.1f%%\n", $2, $3, $4, $5, 100-usage_num}' && \
echo "" && \
df -h --exclude-type=tmpfs --exclude-type=devtmpfs | awk 'NR>1 && $1!~/^total$/ {usage_num=substr($5,1,length($5)-1); printf "%s mount: Used %s, Free %s, Usage %s, Available %.1f%%\n", $6, $3, $4, $5, 100-usage_num}' && \
echo "" && \
# System uptime
echo "Uptime: $(uptime -p)" && \
# Load averages
echo "Load Averages: $(cat /proc/loadavg | awk '{print $1, $2, $3}')" && \
echo "" && \
# Show local IPv4 addresses
ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | while read -r ip; do echo "Local IPv4: $ip"; done && \
# Show local IPv6 addresses (global scope)
ip -6 addr show scope global | grep -oP '(?<=inet6\s)[\da-f:]+(?=/)' | while read -r ip; do echo "Local IPv6: $ip"; done && \
# Public IP addresses
echo "Public IPv4: $(curl -4 -s icanhazip.com)" && \
echo "Public IPv6: $(curl -6 -s icanhazip.com)" && \
echo "" && \
echo "############################ SYSTEM INFORMATION ############################" && echo ""
````

<!-- footer -->
---

## 🧑‍💻 Consulting and technical support
* For personal support and queries, please submit a new issue to have it addressed.
* For commercial related questions, please [**contact me**][ivancarlos] for consulting costs. 

| 🩷 Project support |
| :---: |
If you found this project helpful, consider [**buying me a coffee**][buymeacoffee]
|Thanks for your support, it is much appreciated!|

[cc]: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-code-of-conduct-to-your-project
[contributing]: https://docs.github.com/en/articles/setting-guidelines-for-repository-contributors
[security]: https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository
[support]: https://docs.github.com/en/articles/adding-support-resources-to-your-project
[it]: https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository#configuring-the-template-chooser
[prt]: https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository
[funding]: https://docs.github.com/en/articles/displaying-a-sponsor-button-in-your-repository
[ivancarlos]: https://ivancarlos.me
[buymeacoffee]: https://buymeacoffee.com/ivancarlos
[patreon]: https://www.patreon.com/ivancarlos
[paypal]: https://icc.gg/donate
[sponsor]: https://github.com/sponsors/ivancarlosti
