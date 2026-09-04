hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = "1.0",
})

hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@74.97",
	position = "-1920x0",
	scale = "1.0",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@74.97",
	position = "-1920x0",
	scale = "1.0",
})
--
--  hl.workspace_rule({
--    workspace = "1",
--    monitor = "HDMI-A-1",
--    default = true,
--  })
--
--  hl.workspace_rule({
--    workspace = "1",
--    monitor = "HDMI-A-2",
--    default = true,
--  })
--
--  hl.workspace_rule({
--    workspace = "2",
--    monitor = "eDP-1",
--    default = true,
--  })
