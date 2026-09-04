local polkit_agent = "/usr/lib/polkit-kde-authentication-agent-1"
local startup_sound = "pw-play ~/.local/share/sounds/samsung-winxp/stereo/desktop-login.oga"

local function is_uwsm()
	local f = io.open("/proc/self/cgroup", "r")
	if not f then
		return false
	end
	local content = f:read("*a")
	f:close()
	return content:find("wayland%-wm@") ~= nil
end

hl.on("hyprland.start", function()
	-- checks if UWSM is running
	if is_uwsm() then
		-- local msg = is_uwsm() and "UWSM detected" or "UWSM not detected"
		hl.exec_cmd("quickshell")
		hl.exec_cmd('notify-send "Session check" "' .. "UWSM detected" .. '"')
		hl.exec_cmd(startup_sound)
	else
		hl.exec_cmd("quickshell")
		hl.exec_cmd("swaync")
		hl.exec_cmd("steam -silent")
		hl.exec_cmd("vesktop --start-minimized")
		hl.exec_cmd("easyeffects --gapplication-service")
		hl.exec_cmd("fleasion-launch --no-dashboard")
		hl.exec_cmd(startup_sound)
		-- hl.exec_cmd("nm-applet")
		-- hl.exec_cmd("blueman-applet")
		-- hl.exec_cmd("polychromatic-tray-applet")
		-- hl.exec_cmd("arch-update --tray")
	end
	hl.exec_cmd(polkit_agent)
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("xhost +si:localuser:root")
	hl.exec_cmd("hyprctl setcursor Win10OS-cursors 24")
	hl.exec_cmd("hyprpm reload -n")
end)
