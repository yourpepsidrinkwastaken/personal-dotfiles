local terminal = "kitty"
local fileManager = "thunar"
local menu = "qs -c noctalia-shell ipc call launcher toggle"
local bar = "qs -c noctalia-shell ipc call bar toggle"
-- local disable_bar = "pkill -SIGUSR1 waybar"
local ss = "hyprshot -m region"
local ss_fs = "hyprshot -m output -m active"
local wall = "qs -c noctalia-shell ipc call wallpaper toggle"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind("SUPER + C", hl.dsp.window.close())
closeWindowBind:set_enabled(true)
hl.bind(
	"CTRL + ALT + DELETE",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle"))
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + D", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd(bar))
-- hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd(disable_bar))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(ss))
hl.bind("Print", hl.dsp.exec_cmd(ss_fs))
hl.bind("SUPER + W", hl.dsp.exec_cmd(wall))

hl.bind("SUPER + CTRL + G", hl.dsp.submap("clean"))
hl.define_submap("clean", function()
	hl.bind("SUPER + CTRL + G", hl.dsp.submap("reset"))
end)

-- Move focus with  + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with  + [0-9]
-- Move active window to a workspace with  + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	local code = (key == 0) and 19 or (key + 9) -- for french keyboard, thanks claude
	hl.bind("SUPER + code:" .. code, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind("SUPER + U", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with  + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with  + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume increase"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume decrease"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteOutput"),
	{ locked = true, repeating = true }
)
-- hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media next "), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playpause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media play"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media previous"), { locked = true })

hl.bind("XF86Launch1", hl.dsp.exec_cmd("DAMX"))
