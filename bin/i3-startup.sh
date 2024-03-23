#!/bin/bash


# Setup monitors xrandr --output DP-2 --primary
xrandr --output DP-2 --primary --mode 1920x1080 --rate 244
xrandr --output DP-0 --right-of DP-2 --mode 1920x1080 --rate 144
xrandr --output HDMI-0 --left-of DP-2 --mode 1920x1080 --rate 144

i3-msg 'workspace 3; move workspace to output DP-0'
i3-msg 'workspace 1; move workspace to output HDMI-0'
i3-msg 'workspace 2; move workspace to output DP-2'

# random_image=$(find "$HOME/Pictures/Background Images" -type f | shuf -n 1)
# feh --no-fehbg --bg-scale "$random_image"

feh --bg-scale "$HOME/Pictures/Background Images/Shanghai.png"

# Change keyboard layout to Swedish
setxkbmap se

# Set CAPS equivalent to CTRL
setxkbmap -option "caps:ctrl_modifier"
pkill picom
picom --config ~/.config/picom/picom.conf 


pkill polybar
polybar hidden 
polybar main 

~/bin/xborder --config ~/.config/xborder/xborder.conf
