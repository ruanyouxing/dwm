 print_date()
 {
 date="$(date "+%F")"
   echo -ne "  ${date} "
 }
 print_time()
 {
 time="$(date "+%H:%M:%S")"
   echo -ne "  ${time} "
 }
 print_sound()
 {
  mix=`amixer get Master | tail -1`
     vol="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
     if [[ $mix == *\[off\]* ]]; then                                               
       echo -ne "  MUTED "
     elif [ "$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')" == "0" ]; then
       echo -ne "  MUTED "
     elif [ "$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')" == "100" ]; then
       echo -ne "  MAX "
     else
       echo -ne "  ${vol}% "
     fi
 }

 print_memory()
 {
 case "$1" in
     --popup)
         notify-send "Memory (%)" "$(ps axch -o cmd:10,pmem k -pmem | head | awk '$0=$0"%"' )"
         ;;
     *)
         echo "  $(free -h --si | awk '/^Mem:/ {print $3 "/" $2}') "
         ;;
 esac
 }

 print_cpu()
 {
        echo "  $(grep 'cpu ' /proc/stat | awk '{cpu_usage=($2+$4)*100/($2+$4+$5)} 
	END {printf "%0.2f%", cpu_usage}') "
 }

 print_temperature()
 {

        echo "  $(sensors | grep temp1 | head -1 | awk '{print $2}') "
 }

 print_hddfree() {
  hddfree="$(df -Ph /dev/sda2 | awk '$3 ~ /[0-9]+/ {print $4}')"
  echo -ne "  ${hddfree} "
}
 while true; do
	 xsetroot -name " ;$(uname)|$(whoami);$(print_hddfree)|$(print_sound)|$(print_cpu)|$(print_temperature)|$(print_memory)|$(print_time)|$(print_date)"
 sleep 1 
 done 
