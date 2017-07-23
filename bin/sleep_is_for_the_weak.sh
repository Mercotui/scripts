#! /bin/env bash
#   This script will once every couple of minutes, check for any
#   fullscreen windows, and if it finds any more than normal,
#   dissables powersaving/sleep-mode. Usefull for i.e. watching movies.
regex_filter="(?!\s{5,})(0x[0-9a-f]{7})"

#while true; do
count=$(
    xwininfo -display :0 -tree -root | grep -Po $regex_filter | #get all window IDs
    while read line ; do                            #and for each do
        xwininfo -display :0 -wm -id $line | grep Fullscreen;   #check for fullscreen
    done | wc -l                                    #count
)

if ((count > 0))
then #dissable sleep modes
    echo 'count is '$count' dissable sleepmodes'
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
else #enable sleep modes (hardcoded timing in seconds)
    echo 'count is '$count' enable sleepmodes'
    gsettings set org.gnome.desktop.session idle-delay 300
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type suspend
fi

#sleep 4m;
#done
