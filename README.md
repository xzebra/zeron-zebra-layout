# Zeron Zebra Layout

A Zeron template with compact sidebar rows and a pinned conversation summary.

## Install

In Zeron beta, open **Settings → Templates → Install** and paste:

```text
https://github.com/xzebra/zeron-zebra-layout
```

You can also download `simple-rows.zeron-template` from the latest release and use **Choose file**.

## Source

`zeron-template.json` at the repository root contains the signed template manifest. The files listed in `signature.files` are checked in alongside it. They match the signed package attached to release `v1.2.1`.

The current Zeron beta installs repository links from GitHub release assets. Keeping the release asset makes installation work without changing Zeron. Git tags alone are not an install source in this beta.

When publishing an update, export a fresh signed `.zeron-template` package from Zeron, update the root manifest and its files from that package, and attach the package to a GitHub release. Editing signed files requires exporting and signing again.

## Version 1.2.1

- Restore links and inline code on a fresh app launch by declaring the current transcript accent tokens.
- Add current quote/list marker and file/mention chip tokens.
- Preserve the compact layout and custom ChatGPT colors.

## Version 1.2.0

- Sidebar chat names and section titles use 14pt text, with regular-weight chat names.
- Project-section icons match the 16px project icons in chat rows and are vertically centered.
- Pinned-summary Changes counts match the label size and weight; the whole row opens changes.
- Preserve exact added/removed colors for the custom ChatGPT theme when it is installed.
- Shared Git/GitHub diff components use flat panels, tighter gutters, and file-type icons.

The fixed file-list column and bottom Pull control are owned by the built-in plugins; collapsing or relocating them still requires plugin changes. System Font and the custom ChatGPT palette are app settings, not bundled theme installation.

For manual sidebar sizing, edit `LABEL_SIZE` near the top of `ds/sidebar.luau`. Local edits need a fresh export before publishing a signed update.

File icons include the Symbols license in `assets/icons/files/LICENSE.symbols`.

Installed from the repository link, Zeron checks for newer signed releases. Updates require Zeron’s own approval; no manual file download is needed.
