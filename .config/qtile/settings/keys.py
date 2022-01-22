# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy


mod = "mod4"

keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),

    # Change window sizes (MonadTall)
    ([mod, "shift"], "l", lazy.layout.grow()),
    ([mod, "shift"], "h", lazy.layout.shrink()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Move windows up or down in current stack
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    ([mod], "w", lazy.window.kill()),

    # Switch focus of monitors
    ([mod], "period", lazy.next_screen()),
    ([mod], "comma", lazy.prev_screen()),

    # Switch keyboard layout
    ([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "control"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    ([mod], "m", lazy.spawn("rofi -show drun")),

    # Window Nav
    ([mod, "shift"], "m", lazy.spawn("rofi -show")),

    # dmenu 
    ([mod], "p", lazy.spawn("dmenu_run")),

    # passmenu
    ([mod,"shift"], "d", lazy.spawn("passmenu")),

    # Browser
    ([mod], "b", lazy.spawn("firefox")),
    # ([mod], "b", lazy.spawn("brave")),

    # File Explorer
    ([mod], "e", lazy.spawn("pcmanfm")),

    # Terminal
    ([mod], "Return", lazy.spawn("alacritty")),
    # ([mod], "Return", lazy.spawn("xfce4-terminal")),

    # Redshift
    # ([mod], "r", lazy.spawn("redshift -O 4400")),
    # ([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    ([mod], "s", lazy.spawn("scrot Pictures/screenshots/%Y-%m-%d-%T-screenshot.png")),
    ([mod, "shift"], "s", lazy.spawn("scrot -s Pictures/screenshots/%Y-%m-%d-%T-screenshot.png")),

    # Telegram
    ([mod], "t", lazy.spawn("telegram-desktop")),

    # EmacsClient
    ([mod], "o", lazy.spawn("emacsclient -c -a 'emacs'")),

    # ScreenSaver
    ([mod, "control"], "z", lazy.spawn("slock")),

    # ------------ Hardware Configs ------------

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),

    # Brightness
    ([mod, "control"], "m", lazy.spawn("brightnessctl set +10%")),
    ([mod, "control"], "n", lazy.spawn("brightnessctl set 10%-")),
]]
