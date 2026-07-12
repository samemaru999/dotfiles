local colors = require("colors")
local settings = require("settings")

sbar.add("item", { position = "left", width = 3 })

local apple_logo = sbar.add("item", "apple_logo", {
	position = "left",
	width = 25,
	padding_left = 0,
	padding_right = 0,
	icon = {
		string = "􀣺",
		color = colors.cmap_1,
		align = "center",
		width = 25,
		font = {
			family = settings.font.icons,
			style = settings.font.style_map["Semibold"],
			size = 13.0,
		},
		padding_left = 0,
		padding_right = 0,
	},
	label = {
		drawing = false,
	},
	background = {
		color = colors.tn_black3,
		border_color = colors.cmap_1,
		border_width = 1,
		corner_radius = 7,
		height = 25,
	},
	popup = {
		align = "left",
	},
	click_script = "sketchybar -m --set apple_logo popup.drawing=toggle",
})

local function hide_popup(command)
	return command .. '; sketchybar -m --set apple_logo popup.drawing=off'
end

sbar.add("item", "preferences_button", {
	position = "popup." .. apple_logo.name,
	icon = "􀺽",
	label = "Preferences",
	click_script = hide_popup("open -a 'System Settings' || open -a 'System Preferences'"),
})

sbar.add("item", "activity_button", {
	position = "popup." .. apple_logo.name,
	icon = "􀒓",
	label = "Activity Monitor",
	click_script = hide_popup("open -a 'Activity Monitor'"),
})

sbar.add("item", "lock_button", {
	position = "popup." .. apple_logo.name,
	icon = "􀒳",
	label = "Lock Screen",
	click_script = hide_popup("pmset displaysleepnow"),
})

sbar.add("item", "sleep_button", {
	position = "popup." .. apple_logo.name,
	icon = "􀶠",
	label = "Sleep",
	click_script = hide_popup("pmset sleepnow"),
})

sbar.add("item", "reload_button", {
	position = "popup." .. apple_logo.name,
	icon = "􀖋",
	label = "Reload SketchyBar",
	click_script = "sketchybar --reload",
})

apple_logo:subscribe("mouse.exited.global", function()
	apple_logo:set({ popup = { drawing = false } })
end)

sbar.add("item", { width = 4 })
