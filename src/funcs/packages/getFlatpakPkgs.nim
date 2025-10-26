import
  std/[strutils, osproc]

proc getFlatpakPkgs*(): string =
  var count = osproc.execCmdEx("flatpak list | wc -l")[0]
  count.stripLineEnd
  result = count