-- Session-card fit and preference, ported from shell/session_info.rs.
-- main is the settled chat width, before a sidebar starts animating.
local prefs = require("@app/screens/settings/prefs")
local M = {}
M.width = 272
M.inset = 12
M.gap = 24
M.main = ui.state("zebra_summary_main_width", 0)
M.hidden = ui.persist("zebra_summary_hidden", false)
M.overlay = ui.state("zebra_summary_overlay", false)

function M.reserve(): number?
 local main = M.main:get()
 local transcript = prefs.conversation_width:get()
 local left = main - M.width - M.inset
 local reserve = math.max(main + transcript - 2 * (left - M.gap), 0)
 return if main - reserve - 96 >= transcript - 0.5 then reserve else nil
end
function M.fits(): boolean
 return M.reserve() ~= nil
end
function M.shown(): boolean
 return if M.fits() then not M.hidden:get() else M.overlay:get()
end
function M.toggle()
 if M.fits() then M.hidden:set(not M.hidden:peek())
 else M.overlay:set(not M.overlay:peek()) end
end
return M
