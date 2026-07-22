pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Startup errors (only fires if we fell back to the default config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

local catppuccin = {
    rosewater = "#f5d0dc",
    flamingo  = "#f2b8a0",
    pink      = "#f5a97f",
    mauve     = "#c6a0f6",
    red       = "#f38ba8",
    maroon    = "#eba0ac",
    peach     = "#f9e2af",
    yellow    = "#e6e2b3",
    green     = "#a6d189",
    teal      = "#81c8be",
    sky       = "#99d1db",
    sapphire  = "#85c1e9",
    blue      = "#74c7ec",
    lavender  = "#b4befe",
    text      = "#cdd6f4",
    subtext1  = "#bac2de",
    subtext0  = "#a6adc8",
    overlay2  = "#9399b2",
    overlay1  = "#7f849c",
    overlay0  = "#6c7086",
    surface2  = "#585b70",
    surface1  = "#45475a",
    surface0  = "#313244",
    base      = "#1e1e2e",
    mantle    = "#181825",
    crust     = "#11111b",
}

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Fonts: FiraCode Nerd Font for text, FontAwesome for the bar icon glyphs (via markup).
beautiful.font = "FiraCode Nerd Font 10"

-- Borders (Qtile: border_focus=sky, border_normal=surface0, border_width=2, margin=1)
beautiful.border_width  = 2
beautiful.border_focus  = catppuccin.sky
beautiful.border_normal = catppuccin.surface0
beautiful.useless_gap   = 1

-- Bar / taglist colors (Qtile: bar background=crust, GroupBox focus=sapphire)
beautiful.bg_normal        = catppuccin.crust
beautiful.fg_normal        = catppuccin.text
beautiful.bg_systray       = catppuccin.crust
beautiful.taglist_bg_focus = catppuccin.sapphire
beautiful.taglist_fg_focus = catppuccin.crust

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

-- A colored FontAwesome glyph, e.g. icon("&#xf028;", catppuccin.sky) for the volume icon.
local function icon(glyph, color)
    return wibox.widget{
        markup = string.format('<span font="FontAwesome 12" color="%s">%s</span>', color, glyph),
        widget = wibox.widget.textbox,
    }
end

-- A vertical separator (Qtile: Sep(linewidth=1, padding=10)).
local function sep()
    return wibox.widget{
        widget       = wibox.widget.separator,
        orientation  = "vertical",
        forced_width = 11,
        color        = catppuccin.surface2,
    }
end

local volume_widget = awful.widget.watch(
    { "bash", "-c",
      [[m=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -oE '(yes|no)'); ]] ..
      [[if [ "$m" = yes ]; then echo muted; ]] ..
      [[else pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oE '[0-9]+%' | head -1; fi]] },
    2,
    function(w, stdout)
        local s = stdout:gsub("%s+$", "")
        w:set_text(" " .. s)
    end
)

local function battery_widget(bat)
    return awful.widget.watch(
        { "bash", "-c",
          "cap=$(cat /sys/class/power_supply/" .. bat .. "/capacity 2>/dev/null); " ..
          "st=$(cat /sys/class/power_supply/" .. bat .. "/status 2>/dev/null); " ..
          "echo \"$st $cap\"" },
        30,
        function(w, stdout)
            local st, cap = stdout:match("(%S+)%s+(%S+)")
            if not cap then w:set_text("? --"); return end
            local char = "?"
            if st == "Charging" then char = "^"
            elseif st == "Discharging" then char = "V"
            elseif st == "Full" or st == "Not" then char = "="  -- "Not charging"
            end
            w:set_text(char .. " " .. cap .. "%")
        end
    )
end

local battery0_widget = battery_widget("BAT0")
local battery1_widget = battery_widget("BAT1")

local pomodoro = {
    active    = false,
    state     = "inactive",   -- "work" | "break" | "inactive"
    remaining = 0,
    work_len  = 25 * 60,
    rest_len  = 5 * 60,
    widget    = wibox.widget.textbox(),
}

local function fmt_time(s)
    return string.format("%02d:%02d", math.floor(s / 60), s % 60)
end

function pomodoro.render()
    local color, text
    if pomodoro.state == "work" then
        color, text = catppuccin.green, fmt_time(pomodoro.remaining)
    elseif pomodoro.state == "break" then
        color, text = catppuccin.yellow, fmt_time(pomodoro.remaining)
    else
        color, text = catppuccin.red, "--:--"
    end
    pomodoro.widget:set_markup(string.format('<span color="%s">%s</span>', color, text))
end

pomodoro.timer = gears.timer({ timeout = 1 })
pomodoro.timer:connect_signal("timeout", function()
    pomodoro.remaining = pomodoro.remaining - 1
    if pomodoro.remaining <= 0 then
        if pomodoro.state == "work" then
            pomodoro.state, pomodoro.remaining = "break", pomodoro.rest_len
        else
            pomodoro.state, pomodoro.remaining = "work", pomodoro.work_len
        end
    end
    pomodoro.render()
end)

function pomodoro.toggle()
    if pomodoro.active then
        pomodoro.active, pomodoro.state = false, "inactive"
        pomodoro.timer:stop()
    else
        pomodoro.active, pomodoro.state, pomodoro.remaining = true, "work", pomodoro.work_len
        pomodoro.timer:start()
    end
    pomodoro.render()
end

pomodoro.render()

local mytextclock = wibox.widget.textclock("%Y-%m-%d %H:%M")
local mykeyboardlayout = awful.widget.keyboardlayout()

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    -- Tags (Qtile groups): 6 workspaces named 1..6, first layout = tile.
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])

    -- Layoutbox (Qtile: widget.CurrentLayout)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Taglist (Qtile: widget.GroupBox)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Tasklist (Qtile: widget.WindowName) — the middle, expanding widget.
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }

    -- The bar itself (Qtile: bar.Bar(size=24), background crust).
    s.mywibox = awful.wibar({ position = "top", height = 24, screen = s,
                              bg = catppuccin.crust })

    -- Right-hand widget cluster, assembled conditionally per screen.
    local right = { layout = wibox.layout.fixed.horizontal }
    local function add(w) right[#right + 1] = w end

    if s.index == 1 then
        add(wibox.widget.systray())      -- StatusNotifier lives on screen 1
        add(sep())
    end
    add(icon("&#xf108;", catppuccin.green)); add(s.mylayoutbox); add(sep())
    add(icon("&#xf11c;", catppuccin.red));   add(mykeyboardlayout); add(sep())
    add(icon("&#xf028;", catppuccin.sky));   add(volume_widget); add(sep())
    add(icon("&#xf240;", catppuccin.pink));  add(battery0_widget)
    add(icon("&#xf240;", catppuccin.pink));  add(battery1_widget); add(sep())
    if s.index == 2 then
        add(icon("&#xf254;", catppuccin.red)); add(pomodoro.widget); add(sep())
    end
    add(icon("&#xf017;", catppuccin.peach)); add(mytextclock)

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {   -- Left
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist,  -- Middle (WindowName)
        right,         -- Right
    }
end)

local kb_layouts = { "us", "latam" }
local kb_current = 1
local function next_keyboard()
    kb_current = kb_current % #kb_layouts + 1
    awful.spawn("setxkbmap " .. kb_layouts[kb_current])
end

globalkeys = gears.table.join(
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("brightnessctl set 5%-") end),
    awful.key({ }, "XF86MonBrightnessUp",   function () awful.spawn("brightnessctl set +5%") end),

    awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%") end),
    awful.key({ }, "XF86AudioMute",        function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),

    awful.key({ modkey }, "equal", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%") end),
    awful.key({ modkey }, "minus", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%") end),

    awful.key({ modkey }, "space", next_keyboard, { description = "next keyboard layout", group = "awesome" }),

    awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left")  end, { description = "focus left",  group = "client" }),
    awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right") end, { description = "focus right", group = "client" }),
    awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down")  end, { description = "focus down",  group = "client" }),
    awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up")    end, { description = "focus up",    group = "client" }),
    awful.key({ modkey }, "backslash", function () awful.client.focus.byidx(1) end, { description = "focus next", group = "client" }),

    awful.key({ modkey, "Control" }, "h", function () awful.client.swap.bydirection("left")  end, { description = "move window left",  group = "client" }),
    awful.key({ modkey, "Control" }, "l", function () awful.client.swap.bydirection("right") end, { description = "move window right", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function () awful.client.swap.bydirection("down")  end, { description = "move window down",  group = "client" }),
    awful.key({ modkey, "Control" }, "k", function () awful.client.swap.bydirection("up")    end, { description = "move window up",    group = "client" }),

    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incmwfact(-0.05) end, { description = "shrink (master width -)", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incmwfact( 0.05) end, { description = "grow (master width +)",   group = "layout" }),
    awful.key({ modkey, "Shift" }, "j", function () awful.tag.incnmaster( 1, nil, true) end, { description = "more master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "k", function () awful.tag.incnmaster(-1, nil, true) end, { description = "fewer master clients", group = "layout" }),
    awful.key({ modkey }, "n", function ()
        local t = awful.screen.focused().selected_tag
        if t then t.master_width_factor = 0.5; t.master_count = 1 end
    end, { description = "reset window sizes", group = "layout" }),

    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end, { description = "launch terminal", group = "launcher" }),
    awful.key({ modkey }, "Tab",    function () awful.layout.inc(1) end,   { description = "next layout", group = "layout" }),

    awful.key({ modkey }, "period", function () awful.screen.focus_relative( 1) end, { description = "next screen", group = "screen" }),
    awful.key({ modkey }, "comma",  function () awful.screen.focus_relative(-1) end, { description = "previous screen", group = "screen" }),

    awful.key({ modkey }, "e", function () awful.spawn("pcmanfm") end),
    awful.key({ modkey }, "t", function () awful.spawn("Telegram") end),
    awful.key({ modkey }, "z", function () awful.spawn("zapzap") end),
    awful.key({ modkey }, "o", function () awful.spawn.with_shell("emacsclient -c -a 'emacs'") end),
    awful.key({ modkey }, "s", function () awful.spawn("strawberry") end),
    awful.key({ modkey }, "b", function () awful.spawn("brave") end),
    awful.key({ modkey }, "r", function () awful.spawn("dmenu_run -h 24") end, { description = "spawn dmenu", group = "launcher" }),
    awful.key({ modkey }, "p", function () pomodoro.toggle() end, { description = "toggle pomodoro", group = "awesome" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "r", function ()
        -- Qtile KeyChord emulation. One key press -> one command, then release the grab.
        local chord = {
            q = "dm-logout",
            p = "passmenu -h 24",
            n = "dm-note",
            b = "dm-websearch",
            s = "flameshot gui",
            c = "dm-confedit",
            m = "rofi -show drun",
            -- r handled below (plain = warm, Shift = reset)
        }
        local grabber
        grabber = awful.keygrabber.run(function(mod, key, event)
            if event == "release" then return end
            awful.keygrabber.stop(grabber)
            local shift = false
            for _, m in ipairs(mod) do if m == "Shift" then shift = true end end
            local cmd
            if key == "r" and shift then cmd = "redshift -x"
            elseif key == "r" then cmd = "redshift -O 4400"
            else cmd = chord[key] end
            if cmd then awful.spawn.with_shell(cmd) end
        end)
    end, { description = "system controls chord", group = "awesome" }),

    awful.key({ modkey, "Mod1" }, "l", function () awful.spawn("slock") end,     { description = "lock screen", group = "awesome" }),
    awful.key({ modkey, "Mod1" }, "q", function () awful.spawn("dm-logout") end, { description = "logout menu",  group = "awesome" })
)

for i = 1, 6 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function ()
            local tag = awful.screen.focused().tags[i]
            if tag then tag:view_only() end
        end, { description = "view tag #" .. i, group = "tag" }),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" })
    )
end

clientkeys = gears.table.join(
    awful.key({ modkey }, "w", function (c) c:kill() end, { description = "kill window", group = "client" }),
    awful.key({ modkey }, "f", function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "Return", function (c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" })
)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end),
    awful.button({ modkey }, 2, function (c) c:raise() end)
)

root.keys(globalkeys)

awful.rules.rules = {
    -- All clients
    { rule = { },
      properties = {
          border_width      = beautiful.border_width,
          border_color      = beautiful.border_normal,
          focus             = awful.client.focus.filter,
          raise             = true,
          keys              = clientkeys,
          buttons           = clientbuttons,
          screen            = awful.screen.preferred,
          placement         = awful.placement.no_overlap + awful.placement.no_offscreen,
          titlebars_enabled = false,
      }
    },

    -- Floating (Qtile float_rules): class matches wm_class, name matches title.
    { rule_any = {
        class = {
            "confirmreset",     -- gitk
            "makebranch",       -- gitk
            "maketag",          -- gitk
            "ssh-askpass",
            "pinentry-gtk",
            "Blueman-manager",
        },
        name = {
            "branchdialog",     -- gitk
            "pinentry",         -- GPG key password entry
        },
      }, properties = { floating = true } },

    -- Qtile floats dialogs by default (default_float_rules).
    { rule_any = { type = { "dialog" } }, properties = { floating = true } },
}

client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

menubar.utils.terminal = terminal

awful.spawn.with_shell("~/.config/awesome/autostart.sh")
