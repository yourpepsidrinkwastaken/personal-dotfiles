local colors = require("colors")
-- local smw = require("plugins.split-monitor-workspaces")

function setup_vkfix()
	if hl.plugin.csgo_vulkan_fix ~= nil then
		hl.plugin.csgo_vulkan_fix.vkfix_app({ app = "cs2", w = 1920, h = 1080 })
		hl.config({
			plugin = {
				csgo_vulkan_fix = {
					fix_mouse = true,
				},
			},
		})
	end
end

-- hl.plugin.csgo_vulkan_fix.vkfix_app({ app = "org.vinegarhq.Sober", w = 1280, h = 920 })

--  hl.config({
--    plugin = {
--      hyprbars = {
--        enabled = false,
--        bar_color = colors.surface,
--        bar_height = 24,
--        bar_blur = true,
--        col = {
--          text = colors.on_surface,
--        },
--        bar_title_enabled = true,
--        bar_text_size = 12,
--        bar_text_font = "JetBrainsMono Nerd Font Propo",
--        bar_text_align = "left",
--        bar_part_of_window = true,
--        bar_precedence_over_border = true,
--      },
--    },
--  })
