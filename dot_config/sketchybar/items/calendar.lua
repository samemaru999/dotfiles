local icons = require("icons")
local settings = require("settings")
local colors = require("colors")

local date = sbar.add("item", "calendar.date", {
	position = "right",
	icon = {
		string = icons.calendar,
		color = colors.tn_orange,
		padding_left = 6,
		padding_right = 4,
	},
	label = {
		color = colors.tn_white1,
		font = { family = settings.font.numbers },
		padding_left = 0,
		padding_right = 6,
	},
	update_freq = 60,
	padding_left = 0,
	padding_right = 0,
})

local time = sbar.add("item", "calendar.time", {
	position = "right",
	icon = {
		string = icons.clock,
		color = colors.tn_yellow,
		padding_left = 6,
		padding_right = 4,
	},
	label = {
		color = colors.tn_white1,
		font = { family = settings.font.numbers },
		padding_left = 0,
		padding_right = 6,
	},
	update_freq = 30,
	padding_left = 0,
	padding_right = 0,
})

sbar.add("bracket", "calendar.bracket", { date.name, time.name }, {
	background = {
		color = colors.tn_black3,
		height = 28,
		border_color = colors.tn_blue,
	},
})

sbar.add("item", { position = "right", width = settings.group_paddings })

date:subscribe({ "forced", "routine", "system_woke" }, function()
	date:set({ label = os.date("%m/%d %a") })
end)

time:subscribe({ "forced", "routine", "system_woke" }, function()
	time:set({ label = os.date("%H:%M") })
end)

sbar.add("item", { position = "right", width = 6 })
