local autoexec = "autoexec"
local binds = "binds"

require(autoexec)
require("monitors")
require("env")
require("general")
require(binds)
require("windowrules")
require("plugins")
require("animations.end4")

-- somewhere in your Hyprland config
--package.path = package.path .. ";./?.lua;./?/init.lua"
--local smw = require("plugins.split-monitor-workspaces")
