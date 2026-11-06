-- The original session-details control, hosted by the chat's title strip.
local ds = require("@ds")
local locale = require("@ds/locale")
local route = require("@app/screens/shell/route")
local summary = require("@app/screens/chat/summary_layout")
local lanes = require("@app/screens/chat/lanes")
-- Production's "corner card" glyph (icons.rs `corner_card_glyph`): the
-- sidebar glyph's frame, a card in its top right.
local function corner_card(size: number): Node
	local s = size / 24
	local stroke = 1.75
	local function raw(v: number): any
		return ui.raw(v, "the glyph's own geometry, scaled from its 24-unit source")
	end
	return ui.div {
		relative = true,
		w = size,
		h = size,
		shrink = 0,
		ui.div {
			absolute = true,
			left = (3 - stroke / 2) * s,
			top = (4 - stroke / 2) * s,
			w = (18 + stroke) * s,
			h = (16 + stroke) * s,
			rounded = raw((4 + stroke / 2) * s),
			border = "$zeron.glyph.stroke",
			border_color = "$text.secondary",
		},
		ui.div {
			absolute = true,
			right = 6.5 * s,
			top = 7.5 * s,
			w = 5.5 * s,
			h = 4.5 * s,
			rounded = raw(0.875 * s),
			bg = "$text.secondary",
		},
	}
end

return function(): Node
 local size = ds.island.metrics().control
 local function badge(): number return lanes.badge() end
 return ui.row {
  items = "center",
		-- The session's details (its lanes: side chats and subagents), as
		-- Zeron's titlebar toggle: its count while any run, open or not.
		ui.show(
			function(): boolean
				-- The context card is independent of the disabled legacy lanes overlay.
				return route.current:get().name == "session"
			end,
			ui.div {
				relative = true,
				ds.IconButton {
					id = "titlebar-session-details",
					label = function(): string
						local open = summary.shown()
						return locale.s(if open then "shell.title_bar.hide_details" else "shell.title_bar.show_details")
					end,
					tooltip_side = "bottom",
					w = size,
					h = size,
					lit = function(): boolean
						return summary.shown()
					end,
					on_click = function()
						summary.toggle()
					end,
					corner_card(16),
				},
				ui.show(
					function(): boolean
						return badge() > 0
					end,
					ui.row {
						absolute = true,
						right = -2,
						top = -2,
						h = 13,
						min_w = 13,
						px = ui.raw(3, "production's titlebar count badge (running_pill.rs): its digits 3 in from its round ends"),
						items = "center",
						justify = "center",
						rounded = "$radius.full",
						bg = "$zeron.status.working",
						pointer_events = "none",
						ui.text {
							function(): string
								local n = badge()
								return if n > 99 then "99+" else tostring(n)
							end,
							text_size = "$font.size.xs",
							weight = "$font.weight.medium",
							color = "$background",
							tabular = true,
						},
					}
				),
			}
		),
 }
end
