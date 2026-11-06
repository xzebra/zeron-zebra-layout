-- The normal file-icon map, with inline SVGs readable inside plugin sandboxes.
local FileIcons = require("@self/file_icons")
local svgs = require("@self/git_file_icon_svgs")
return function(props: { name: string, status: string? }): Node
	local key = FileIcons.of(props.name)
	return ui.div {
		w = 16, h = 16, shrink = 0, relative = true,
		tooltip = props.status, aria_hidden = true,
		ui.svg { src = "code:" .. (svgs["light/" .. key] or svgs["light/files/file"] or ""), w = 16, h = 16,
			absolute = true, left = 0, top = 0, opacity = "$zeron.files.light" },
		ui.svg { src = "code:" .. (svgs["dark/" .. key] or svgs["dark/files/file"] or ""), w = 16, h = 16,
			absolute = true, left = 0, top = 0, opacity = "$zeron.files.dark" },
	}
end
