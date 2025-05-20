import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"
keys = [
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),


    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod], "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "control"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
    ),
    Key(
        [mod, "control"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "shift"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Grow window to the left"
    ),
    Key(
        [mod, "shift"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Grow window to the right"
    ),
    Key(
        [mod, "shift"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Grow window down"
    ),
    Key(
        [mod, "shift"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Grow window up"
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),

    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),

    Key([mod], "e", lazy.spawn("pcmanfm")),
    Key([mod], "t", lazy.spawn("telegram-desktop")),
    Key([mod], "z", lazy.spawn("zapzap")),
    Key([mod], "o", lazy.spawn("emacsclient -c -a 'emacs'")),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "b", lazy.spawn("brave")),
    KeyChord([mod, "shift"], "b", [
        Key([], "b", lazy.spawn("brave")),
        Key([], "q", lazy.spawn("qutebrowser")),
        Key([], "f", lazy.spawn("firefox"))
    ]),
    Key([mod], "r", lazy.spawn("dmenu_run -h 24"), desc="Spawn dmenu"),
    KeyChord([mod, "shift"], "r", [
        Key([], "p", lazy.spawn("passmenu -h 24")),
        Key([], "n", lazy.spawn("dm-note")),
        Key([], "b", lazy.spawn("dm-websearch")),
        Key([], "s", lazy.spawn("dm-maim")),
        Key([], "c", lazy.spawn("dm-confedit")),
        Key([], "m", lazy.spawn("rofi -show drun")),
        Key([], "r", lazy.spawn("redshift -O 4400")),
        Key(["shift"], "r", lazy.spawn("redshift -x"))
    ]),
    Key([mod, "mod1"], "l", lazy.spawn("slock")),
    Key([mod, "mod1"], "q", lazy.spawn("dm-logout"))
]


def init_catppuccin():
    return {
        "rosewater": "#f5d0dc",
        "flamingo": "#f2b8a0",
        "pink": "#f5a97f",
        "mauve": "#c6a0f6",
        "red": "#f38ba8",
        "maroon": "#eba0ac",
        "peach": "#f9e2af",
        "yellow": "#e6e2b3",
        "green": "#a6d189",
        "teal": "#81c8be",
        "sky": "#99d1db",
        "sapphire": "#85c1e9",
        "blue": "#74c7ec",
        "lavender": "#b4befe",
        "text": "#cdd6f4",
        "subtext1": "#bac2de",
        "subtext0": "#a6adc8",
        "overlay2": "#9399b2",
        "overlay1": "#7f849c",
        "overlay0": "#6c7086",
        "surface2": "#585b70",
        "surface1": "#45475a",
        "surface0": "#313244",
        "base": "#1e1e2e",
        "mantle": "#181825",
        "crust": "#11111b"
    }


def init_widgets_defaults():
    return dict(
        font="FiraCode Nerd Font",
        fontsize=12,
        padding=2,
        background=catppuccin['crust']
    )


groups = [
        Group(name="1"),
        Group(name="2"),
        Group(name="3"),
        Group(name="4"),
        Group(name="5"),
        Group(name="6"),
        Group(name="7"),
        Group(name="8"),
        Group(name="9"),
        Group(name="0"),
]
catppuccin = init_catppuccin()
widget_defaults = init_widgets_defaults()


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


def init_layout_theme():
    return {
        "margin": 1,
        "border_width": 2,
        "border_focus": catppuccin['sky'],
        "border_normal": catppuccin['surface0'],
    }


layout_theme = init_layout_theme()

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    # layout.MonadTall(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]


def init_widgets_screen1():
    return {
        'widgets': [
            widget.GroupBox(
                borderwidth=2,
                this_current_screen_border=catppuccin['sapphire'],
            ),
            widget.WindowName(),
            widget.Systray(),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['green'],
                **text_box_defaults
            ),
            widget.CurrentLayout(),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['red'],
                **text_box_defaults
            ),
            widget.KeyboardLayout(configured_keyboards=[
                "us",
                "latam",
                # "us dvorak"
            ]),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['pink'],
                **text_box_defaults
            ),
            widget.Battery(
                battery=1,
                fontsize=12,
                format="{char} {percent:2.0%}"
            ),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['peach'],
                **text_box_defaults
            ),
            widget.Clock(format="%Y-%m-%d %H:%M"),
        ],
        'size': 24,
    }


def init_widgets_screen2():
    return {
        'widgets': [
            widget.GroupBox(
                borderwidth=2,
                this_current_screen_border=catppuccin['sapphire'],
            ),
            widget.WindowName(),
            widget.TextBox(
                text="",
                foreground=catppuccin['green'],
                **text_box_defaults
            ),
            widget.CurrentLayout(),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['red'],
                **text_box_defaults
            ),
            widget.KeyboardLayout(configured_keyboards=["us", "latam"]),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['pink'],
                **text_box_defaults
            ),
            widget.Battery(
                battery=1,
                fontsize=12,
                format="{char} {percent:2.0%}"
            ),
            widget.Sep(linewidth=1, padding=10),
            widget.TextBox(
                text="",
                foreground=catppuccin['peach'],
                **text_box_defaults
            ),
            widget.Clock(format="%Y-%m-%d %H:%M"),
        ],
        'size': 24,
    }


widget_defaults = dict(
    font="FontAwesome",
    fontsize=12,
    padding=3,
    foreground=catppuccin['text'],
    background=catppuccin['crust'],
)
extension_defaults = widget_defaults.copy()
text_box_defaults = {'padding': 5, 'fontsize': 14}
screens = [
    Screen(
        top=bar.Bar(**init_widgets_screen1()),
        # You can uncomment this variable if you see that on X11 floating
        # resize/moving is laggy
        # By default we handle these events delayed to already improve
        # performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it
        # to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(top=bar.Bar(**init_widgets_screen2()))
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="pinentry-gtk"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
