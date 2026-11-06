# Zeron Zebra Layout

A Zeron template with compact sidebar rows and a pinned conversation summary.

## Install

In Zeron beta, open **Settings → Templates → Install** and paste:

```text
https://github.com/xzebra/zeron-zebra-layout
```

You can also download `simple-rows.zeron-template` from the latest release and use **Choose file**.

## Source

`zeron-template.json` at the repository root contains the signed template manifest. The files listed in `signature.files` are checked in alongside it. They match the signed package attached to release `v1.1.0`.

The current Zeron beta installs repository links from GitHub release assets. Keeping the release asset makes installation work without changing Zeron. Git tags alone are not an install source in this beta.

When publishing an update, export a fresh signed `.zeron-template` package from Zeron, update the root manifest and its files from that package, and attach the package to a GitHub release. Editing signed files requires exporting and signing again.

## Version 1.1.0

- Pinned device, project, branch, Changes, side chats, and subagents beside the conversation.
- Summary toggle on the chat side of the panel divider, smooth fades, and an opaque background.
- Dedicated Changes row with larger, vivid counts and stronger summary typography.
- Solid blue completed-chat badges; existing sidebar typography and pull-request icons retained.

Installed from the repository link, Zeron checks for newer signed releases. Updates require Zeron’s own approval; no manual file download is needed.
