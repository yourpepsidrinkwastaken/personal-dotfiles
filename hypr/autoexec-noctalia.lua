local polkit_agent = "/usr/lib/polkit-kde-authentication-agent-1"
local cursor = "hyprctl setcursor Win10OS-cursors 24"
local wallpaper = "waypaper --restore"

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd(wallpaper)
	hl.exec_cmd(polkit_agent)
	hl.exec_cmd("swaync")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("xhost +si:localuser:root")
	hl.exec_cmd("steam -silent")
	hl.exec_cmd("discord --start-minimized")
	hl.exec_cmd(cursor)
	hl.exec_cmd("easyeffects --gapplication-service")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("polychromatic-tray-applet")
	hl.exec_cmd("arch-update --tray")
	hl.exec_cmd("hyprpm reload -n")
end)
