import
  std/[strutils, osproc]

proc getBpmPkgs*(): string =
  var count = osproc.execCmdEx("bpm list -c")[0]
  count.stripLineEnd
  result = count
