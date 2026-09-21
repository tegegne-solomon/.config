-- Hyprland 0.56+ configuration (Lua)

local main_mod = "SUPER"
local terminal = "kitty"
local launcher = "rofi -show drun"
local browser = "firefox"
local editor = "code"
local workspace = {
    editor = 1,
    browser = 2,
    terminal = 3,
    files = 4,
    media = 5,
}

-- ---------- Monitor and environment ----------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.env("XCURSOR_THEME", "hyprland_theme")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_THEME", "hyprland_theme")
hl.env("HYPRCURSOR_SIZE", "32")

-- ---------- Settings ----------
hl.config({
    input = {
        kb_layout = "us,us",
        kb_variant = "dvorak,",
        kb_options = "grp:win_space_toggle",
        repeat_rate = 80,
        repeat_delay = 200,
    },

    general = {
        layout = "master",
        gaps_in = 2,
        gaps_out = 4,
        border_size = 4,
        col = {
            active_border = { colors = { "rgba(6699ccff)", "rgba(3366aaff)" }, angle = 45 },
            inactive_border = "rgba(333333aa)",
        },
    },

    decoration = {
        rounding = 15,
        shadow = { enabled = false },
        blur = { enabled = false },
    },

    animations = { enabled = false },

    master = {
        mfact = 0.50,
        new_status = "slave",
        orientation = "center",
    },

    cursor = {
        hide_on_key_press = false,
        warp_back_after_non_mouse_input = true,
        inactive_timeout = 0,
        no_hardware_cursors = true,
        use_cpu_buffer = true,
    },

    misc = {
        vrr = 1,
        focus_on_activate = true,
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        allow_session_lock_restore = true,
    },
})

-- ---------- Window rules ----------
hl.window_rule({ name = "code-workspace", match = { class = "^(code|Code|vscode)$" }, workspace = workspace.editor })
hl.window_rule({
    name = "browser-workspace",
    match = { class = "^(firefox|google-chrome|chrome)$" },
    workspace = workspace.browser .. " silent",
    no_initial_focus = true,
})
hl.window_rule({ name = "terminal-workspace", match = { class = "^kitty$" }, workspace = workspace.terminal })
hl.window_rule({ name = "files-workspace", match = { class = "^(thunar|xpad)$" }, workspace = workspace.files })
hl.window_rule({ name = "media-workspace", match = { class = "^vlc$" }, workspace = workspace.media })

-- ---------- Startup ----------
hl.on("hyprland.start", function()
    for _, command in ipairs({
        "waybar",
        "hyprpaper",
        -- "firefox",
        "kitty",
        "wl-paste --type text --watch cliphist store",
        "wl-paste --type image --watch cliphist store",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "nm-applet",
        "blueman-applet",
        "hypridle",
        "gsettings set org.gnome.desktop.interface cursor-size 32",
        "hyprctl setcursor hyprland_theme 32",
    }) do
        hl.exec_cmd(command)
    end

    -- Applications start asynchronously. Switch to the terminal workspace
    -- after the delayed Kitty window has had time to map.
    -- hl.exec_cmd("sh -c 'sleep 4; hyprctl dispatch workspace 3'")
end)

-- ---------- Bind helpers ----------
local function bind(keys, dispatcher, description, flags)
    flags = flags or {}
    flags.description = description
    hl.bind(keys, dispatcher, flags)
end

local function command(keys, shell_command, description, flags)
    bind(keys, hl.dsp.exec_cmd(shell_command), description, flags)
end

-- ---------- Core bindings ----------
command(main_mod .. " + Return", terminal, "Open terminal")
command(main_mod .. " + SHIFT + Return", terminal .. " -e btop", "Open system monitor")
bind(main_mod .. " + C", hl.dsp.window.close(), "Close focused window")
bind(main_mod .. " + SHIFT + M", hl.dsp.exit(), "Exit Hyprland")
command(main_mod .. " + R", launcher, "Open application launcher")
command(main_mod .. " + B", browser, "Open browser")
command(main_mod .. " + P", editor, "Open code editor")

-- Workspaces (Dvorak home-row-oriented keys)
for index, key in ipairs({ "A", "O", "E", "U", "I" }) do
    bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = index }), "Focus workspace " .. index)
    bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = index }), "Move window to workspace " .. index)
end

-- Master layout controls
bind(main_mod .. " + M", hl.dsp.layout("swapwithmaster"), "Swap window with master")
bind(main_mod .. " + J", hl.dsp.layout("cyclenext"), "Focus next stack window")
bind(main_mod .. " + K", hl.dsp.layout("cycleprev"), "Focus previous stack window")

-- Focus, movement, and resizing
local directions = {
    left = "l",
    right = "r",
    up = "u",
    down = "d",
}

for key, direction in pairs(directions) do
    bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }), "Focus window " .. key)
    bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }), "Move window " .. key)
end

bind(main_mod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), "Swap window left")
bind(main_mod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), "Swap window right")

bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), "Move window with mouse", { mouse = true })
bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), "Resize window with mouse", { mouse = true })

bind(main_mod .. " + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), "Shrink width")
bind(main_mod .. " + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), "Grow width")
bind(main_mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), "Shrink height")
bind(main_mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), "Grow height")

-- Window states and utilities
bind(main_mod .. " + F", hl.dsp.window.fullscreen(), "Toggle fullscreen")
bind(main_mod .. " + SHIFT + F", hl.dsp.window.float(), "Toggle floating")
bind(main_mod .. " + SHIFT + P", hl.dsp.window.pseudo(), "Toggle pseudo-tile")

command(main_mod .. " + V", "cliphist list | rofi -dmenu | cliphist decode | wl-copy", "Open clipboard history")
command(main_mod .. " + W", "makoctl dismiss", "Dismiss notifications")
command(main_mod .. " + CTRL + E", "thunar", "Open file manager")
command(main_mod .. " + CTRL + P", "pavucontrol", "Open audio settings")

-- Special workspaces
bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("notes"), "Toggle notes workspace")
bind(main_mod .. " + SHIFT + R", hl.dsp.workspace.toggle_special("read"), "Toggle reading workspace")

-- Screenshots: each command stores and copies the same timestamped file.
command("Print", [[dir="$HOME/Pictures/screenshots"; mkdir -p "$dir"; file="$dir/full-$(date +%Y%m%d-%H%M%S).png"; grim "$file" && wl-copy < "$file"]], "Capture full screen")
command(main_mod .. " + Print", [[dir="$HOME/Pictures/screenshots"; mkdir -p "$dir"; file="$dir/area-$(date +%Y%m%d-%H%M%S).png"; grim -g "$(slurp)" "$file" && wl-copy < "$file"]], "Capture area")
command(main_mod .. " + SHIFT + Print", [[grim -g "$(slurp)" /tmp/swappy-edit.png && swappy -f /tmp/swappy-edit.png]], "Capture area for annotation")

-- Power management
command(main_mod .. " + SHIFT + D", "brightnessctl -s set 5%", "Set brightness to 5%")
command(main_mod .. " + SHIFT + B", "brightnessctl -s set 50%", "Set brightness to 50%")
command(main_mod .. " + SHIFT + S", "systemctl suspend", "Suspend system")
command(main_mod .. " + SHIFT + L", "hyprlock", "Lock screen")

-- Media keys
command("XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", "Raise volume", { locked = true, repeating = true })
command("XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", "Lower volume", { locked = true, repeating = true })
command("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", "Toggle mute", { locked = true })
command("XF86MonBrightnessUp", "brightnessctl s 5%+", "Raise brightness", { locked = true, repeating = true })
command("XF86MonBrightnessDown", "brightnessctl s 5%-", "Lower brightness", { locked = true, repeating = true })
command("XF86AudioPlay", "playerctl play-pause", "Play or pause")
command("XF86AudioNext", "playerctl next", "Next track")
command("XF86AudioPrev", "playerctl previous", "Previous track")
command("XF86AudioStop", "playerctl stop", "Stop playback")
