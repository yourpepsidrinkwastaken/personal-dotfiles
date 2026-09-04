-- Ignore Maximize Events from Applications
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

suppressMaximizeRule:set_enabled(true)

-----------------------
-- Disable XDG Drags --
-----------------------
local disableXdgDrags = hl.window_rule({
	name = "disable-xdg-drags",
	match = { class = ".*" },

	no_xdg_drags = true,
})

disableXdgDrags:set_enabled(true)

-- Fix XWayland Dragging Issues
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Custom Window Rules --

hl.window_rule({
	name = "thunar-dialogs",
	match = {
		initial_class = "^(Thunar)$",
		initial_title = "^(File Operation Progress|Properties|Confirm Replace|Rename.*)$",
	},
	float = true,
	center = true,
	size = { 600, 400 },
})

hl.window_rule({
	match = { class = "gmrun" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "nwg-look" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "qt6ct" },
	float = true,
	center = true,
	persistent_size = true,
})

hl.window_rule({
	match = { class = "qt5ct" },
	float = true,
	center = true,
	persistent_size = true,
})

hl.window_rule({
	match = { class = "waypaper" },
	float = true,
	center = true,
	persistent_size = true,
})

hl.window_rule({
	match = { class = "kvantummanager" },
	float = true,
	center = true,
	persistent_size = true,
})

hl.window_rule({
	name = "Sober Fix",
	match = { class = "org.vinegarhq.Sober" },
	immediate = false,
	fullscreen = true,
	no_anim = true,
	no_shadow = true,
	no_blur = true,
	decorate = false,
	confine_pointer = false,
	rounding = 0,
})

hl.window_rule({
	name = "Counter-Strike 2",
	match = { class = "cs2" },
	immediate = true,
	fullscreen = true,
	no_anim = true,
	no_shadow = true,
	no_blur = true,
	decorate = false,
	confine_pointer = true,
	rounding = 0,
})

hl.window_rule({
	match = { class = "ca.desrt.dconf-editor" },
	float = true,
	size = { "(monitor_w*0.35)", "(monitor_h*0.6)" },
})

hl.window_rule({
	match = { class = "com.github.wwmm.easyeffects" },
	float = true,
	size = { "(monitor_w*0.7)", "(monitor_h*0.6)" },
})

hl.window_rule({
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	size = { "(monitor_w*0.65)", "(monitor_h*0.8)" },
})

hl.window_rule({
	match = { class = "pavucontrol-qt" },
	float = true,
	size = { "(monitor_w*0.65)", "(monitor_h*0.8)" },
})

hl.window_rule({
	match = { class = "org.cachyos.hello" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "zen" },
	-- ["hyprbars:no_bar"] = true,
})

hl.window_rule({
	match = { class = "firefox" },
	-- ["hyprbars:no_bar"] = true,
})

hl.window_rule({
	name = "Kitty Blur Fix?",
	match = { class = "kitty" },
	opacity = 0.87,
})

hl.window_rule({
	match = { class = "mame" },
	monitor = "HDMI-A-2",
})

hl.window_rule({
	match = { class = "python3", title = "Dashboard - Fleasion" },
	float = true,
})

-- layer rules

hl.layer_rule({
	match = { class = "rofi" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = { class = "waybar" },
	blur = true,
})

local qs_blur = hl.layer_rule({
	name = "Quickshell Blur",
	match = { class = "quickshell" },
	blur = true,
})

qs_blur:set_enabled(true)

hl.layer_rule({
	match = { class = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	match = { class = "swaync-notification-center" },
	blur = true,
	ignore_alpha = 0.5,
})
