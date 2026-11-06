-- The main window's title bar: the design system's (ds.TitleBar: the
-- window's buttons, the sidebar's toggle, back and forward, at Zeron's
-- places), over the window's top, its island showing while the sidebar is
-- collapsed over a new chat's wallpaper. At its other end, the page's own
-- controls: on a session, its panel's toggle. Plugins place theirs by
-- `#titlebar-actions`.
--
-- `TitleBar { collapsed = state, files = state, art = fn }`

local ds = require("@ds")
local route = require("@app/screens/shell/route")
local fit = require("@app/screens/shell/fit")
local locale = require("@ds/locale")

-- The actions' last width, kept across a reload of the scripts.
local actions_width = ui.state("shell_titlebar_actions_w", 0)

export type Props = {
	collapsed: State<boolean>,
	files: State<boolean>,
	-- Whether the bar stands over a wallpaper (its island shows, collapsed).
	art: () -> boolean,
	caption_over_art: boolean?,
	-- A new chat's page has a panel too (v3's).
	panel_on_home: boolean?,
}


return function(props: Props): Node
	local size = ds.island.metrics().control
	local actions = ui.row {
		id = "titlebar-actions",
		items = "center",
		gap = "$zeron.island.gap",

		ui.show(
			function(): boolean
				-- (A plugin's page has a panel of its own too.)
				-- (Under settings, as the chats stand there: in v3 it's beside them.)
				local name = if props.panel_on_home == true then route.chat:get().name else route.current:get().name
				return name == "session" or name == "plugin" or (props.panel_on_home == true and name == "home")
			end,
			-- The session's panel: the sidebar's glyph mirrored (its panel at
			-- the right), narrowing as the panel closes, as the left one does.
			ds.IconButton {
				label = ui.t("shell.title_bar.panel"),
				tooltip = locale.s("shell.title_bar.panel_tooltip", { key = ui.shortcut_text("cmd+r") }),
				tooltip_side = "bottom",
				w = size,
				h = size,
				on_click = function()
					fit.toggle_panel()
				end,
				ds.SidebarIcon { open = props.files, side = "right", size = 16 },
			}
		),
	}
	return ui.div {
		id = "titlebar",
		absolute = true,
		left = 0,
		right = 0,
		top = 0,
		-- (Over the sidebar's top and the page's: the pointer goes through
		-- to them, but for the bar's own controls.)
		pointer_events = "none",
		ds.TitleBar {
			collapsed = props.collapsed,
			on_toggle = fit.toggle_sidebar,
			-- (No glass behind the window's buttons and the controls: they stand on
			-- the top bar, over nothing but the window.)
			island = function(): boolean
				return false
			end,
			can_back = route.can_back,
			can_forward = route.can_forward,
			on_back = route.back,
			on_forward = route.forward,
			actions = actions,
			-- (Over a new chat's wallpaper, what's in it (a plugin's) stands on
			-- the island's glass, the sidebar open or not.)
			actions_island = props.art,
			caption_over_art = props.caption_over_art,
			actions_width = actions_width,
		},
	}
end
