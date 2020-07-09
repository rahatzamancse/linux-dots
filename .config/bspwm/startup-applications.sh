### Desktop 9
## Telegram
bspc rule -a TelegramDesktop --one-shot desktop='^9'
telegram-desktop &

# Facebook
bspc rule -a vimb:facebook --one-shot desktop='^9'
vimb --name=facebook --class=vimb facebook.com &

## If qutebrowser is prefered to vimb
# bspc rule -a qutebrowser:facebook --one-shot desktop='^9'
# RESOURCE_NAME=facebook qutebrowser --target window facebook.com &

### Desktop 8
## Calendar
PREV_IGNORE_EWMH_FOCUS=$(bspc config ignore_ewmh_focus)
bspc config ignore_ewmh_focus true
bspc rule -a MineTime --one-shot desktop='^8'
minetime & 
bspc config ignore_ewmh_focus PREV_IGNORE_EWMH_FOCUS
unset PREV_IGNORE_EWMH_FOCUS
