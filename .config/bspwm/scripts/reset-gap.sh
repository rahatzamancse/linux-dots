# Some variables
BSPWM_GAP=10
TOP_PANEL_HEIGHT=0
BOTTOM_PANEL_HEIGHT=55
LEFT_PANEL_HEIGHT=0
RIGHT_PANEL_HEIGHT=0
TOP_GAP=5
BOTTOM_GAP=5
LEFT_GAP=5
RIGHT_GAP=5
SHOW_BARS_IN_MONOCLE=true

bspc config window_gap $BSPWM_GAP;
bspc config top_padding $(($TOP_PANEL_HEIGHT-$BSPWM_GAP+$TOP_GAP))
bspc config left_padding $(($LEFT_PANEL_HEIGHT-$BSPWM_GAP+$LEFT_GAP))
bspc config right_padding $(($RIGHT_PANEL_HEIGHT-$BSPWM_GAP+$RIGHT_GAP))
bspc config bottom_padding $(($BOTTOM_PANEL_HEIGHT-$BSPWM_GAP+$BOTTOM_GAP))

bspc config borderless_monocle true
bspc config gapless_monocle false

if [ "$SHOW_BARS_IN_MONOCLE" = true ] ; then
	bspc config top_monocle_padding -$TOP_GAP
	bspc config left_monocle_padding -$TOP_GAP
	bspc config right_monocle_padding -$TOP_GAP
	bspc config bottom_monocle_padding -$TOP_GAP
else
	bspc config top_monocle_padding $((-$TOP_PANEL_HEIGHT-$TOP_GAP))
	bspc config left_monocle_padding $((-$LEFT_PANEL_HEIGHT-$TOP_GAP))
	bspc config right_monocle_padding $((-$RIGHT_PANEL_HEIGHT-$TOP_GAP))
	bspc config bottom_monocle_padding $((-$BOTTOM_PANEL_HEIGHT-$TOP_GAP))
fi
