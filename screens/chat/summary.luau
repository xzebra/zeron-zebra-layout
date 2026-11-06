-- The conversation's fixed summary. Opening a detail still uses the tools
-- panel, but basic context and lane status never depend on that panel.
local Home = require("@app/screens/panel/home")
local lanes = require("@app/screens/chat/lanes")
local state = require("@app/screens/panel/state")
local view = require("@app/screens/shell/view")

return function(sid: string, showing: () -> boolean): Node
	return Home.Summary {
		key = `chat:{sid}`, session = sid, pinned = true, showing = showing,
		open_kind = function(kind: string)
			state.open(`chat:{sid}`, kind :: any)
			view.set_files(true)
		end,
		open_plugin_tab = function(session: string, tab: any)
			require("@app/screens/panel").open_plugin_tab(session, tab)
		end,
		open_action = function(title: string, run: any)
			state.open(`chat:{sid}`, "terminal", { title = title, run = run })
			view.set_files(true)
		end,
		new_side_chat = lanes.new_side_chat,
		fork = lanes.fork,
		side = lanes.side,
		subagents = lanes.subagents,
		open_side = function(session: string, child: any)
			lanes.open(session, { kind = "side_chat", id = child.id, title = child.title })
		end,
		open_subagent = lanes.open_subagent,
		open_url = function(session: string, url: string)
			require("@app/screens/panel").open_url(session, url)
		end,
	}
end
