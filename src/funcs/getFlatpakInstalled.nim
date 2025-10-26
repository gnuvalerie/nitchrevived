import std/[os, osproc]

proc getFlatpakInstalled*(): bool =
    if osproc.execCmdEx("flatpak --version").exitcode == 0:
        result = true
    else:
        result = false