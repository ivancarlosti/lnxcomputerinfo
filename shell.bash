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
