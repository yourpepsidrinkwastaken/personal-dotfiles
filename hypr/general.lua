local colors = require("colors")

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 24,

		border_size = 2,

		col = {
			active_border = colors.primary,
			inactive_border = colors.outline,
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "dwindle",
	},

	decoration = {
		rounding = 18,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 50,
			render_power = 4,
			color = colors.shadow,
			offset = {
				0,
				15,
			},
			scale = 0.98,
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			ignore_opacity = true,
			new_optimizations = true,
			special = false,
			vibrancy = 0.1696,
		},

		motion_blur = {
			enabled = false,
			samples = 7,
		},
	},

	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		disable_splash_rendering = true,
		middle_click_paste = false,
		render_unfocused_fps = 120,
		background_color = colors.scrim,
		vrr = 1,
	},

	input = {
		kb_layout = "fr",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		accel_profile = "adaptive",
		force_no_accel = true,
		follow_mouse = 1,

		sensitivity = 0.3065, -- -1.0 - 1.0, 0 means no modification.

		numlock_by_default = true,
		touchpad = {
			natural_scroll = true,
		},
	},

	cursor = {
		sync_gsettings_theme = true,
		no_hardware_cursors = 0,
		enable_hyprcursor = 1,
		use_cpu_buffer = 0,
	},

	render = {
		direct_scanout = 0,
		new_render_scheduling = true,
	},

	opengl = {
		nvidia_anti_flicker = true,
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
		use_active_for_splits = false,
		precise_mouse_move = true,
	},

	master = {
		mfact = 0.5,
		new_status = "slave",
		orientation = "right",
		always_keep_position = false,
	},

	scrolling = {
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		follow_focus = false,
		explicit_column_widths = "0.333,0.5,0.75,1.0",
	},

	xwayland = {
		enabled = true,
		use_nearest_neighbor = false,
		force_zero_scaling = false,
	},

	debug = {
		vfr = 0,
	},

	ecosystem = {
		enforce_permissions = false,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "razer-razer-deathadder-elite-1",
	sensitivity = 0,
})
