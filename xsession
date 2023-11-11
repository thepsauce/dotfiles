xrdb -merge ~/.Xresources
xrandr --output LVDS-1 --auto --output VGA-1 --auto --right-of LVDS-1
xset r rate 200 50
unclutter -idle 4 &
exec i3
