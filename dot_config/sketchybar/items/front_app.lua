local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.icon_map")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = {
		color = colors.accent1,
		font = "sketchybar-app-font:Regular:12.0",
		padding_left = 4,
		padding_right = 4,
	},
	label = {
		color = colors.accent1,
		font = {
			style = settings.font.style_map["Semibold"],
			size = 10.0,
		},
		max_chars = 18,
		padding_left = 0,
		padding_right = 4,
	},
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	local icon = app_icons[env.INFO] or app_icons["default"]
	front_app:set({
		icon = { string = icon },
		label = { string = env.INFO },
	})
end)
