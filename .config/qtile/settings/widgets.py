from libqtile import widget
from settings.theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=37,
        padding=-2
    )


def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    # powerline('color4', 'dark'),


    icon(bg="dark", text=' '), # Icon: nf-fa-download
    widget.CheckUpdates(
        # background=colors['color4'],
        colour_have_updates=colors['text'],
        colour_no_updates=colors['text'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
    ),

    widget.TextBox(
        fontsize=37,
        padding=-6
    ),

    # powerline('color2', 'color4'),

    # icon(bg="color3", text=' '),  # Icon: nf-fa-feed
    # widget.Net(**base(bg='color2'), interface='wlo1'),
    # widget.Battery(**base(bg='color2')),
    icon(bg="dark", text='  '),
    widget.Pomodoro(**base(bg='dark', fg='light'), color_inactive='ffffff', color_active='ffffff', color_break='ffffff'),
    icon(bg="dark", text=' '),

    # icon(bg="color3", text='墳 ', fg='dark'), 
    # widget.Volume(**base(bg='color3', fg='dark'), volume_app="pamixer"),
    # powerline('color1', 'color3'),
    icon(bg="dark", fontsize=17, text='󰃰 '), # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),
    # powerline('dark', 'color1'),

    widget.KeyboardLayout(configured_keyboards=['latam', 'us dvorak', 'us dvp']),
    widget.CurrentLayoutIcon(**base(bg='dark'), scale=0.65),
    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline('color1', 'dark'),
    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),
    widget.CurrentLayout(**base(bg='color1'), padding=5),
    powerline('color2', 'color1'),
    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M '),
    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
