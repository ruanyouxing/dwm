~/.fehbg && picom &
flameshot &
print_date()
{
date="$(date "+%F")"
  echo -ne "  ${date} "
}
print_time()
{
time="$(date "+%H:%M")"
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
        echo "  $(free -h --si | awk '/^Mem:/ {print $3 "/" $2}')"
        ;;
esac
}


while true; do
# xsetroot -name "$(whoami); $(print_memory)|$(print_date)|$(print_time) |$(print_sound)"
xsetroot -name "$(whoami);$(print_memory)"
sleep 1 
done 
