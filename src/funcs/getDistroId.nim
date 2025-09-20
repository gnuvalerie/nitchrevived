import std/[os, parsecfg]

proc getDistroId*(): string =
  if fileExists("/bedrock/strata/bedrock/etc/os-release"):
    result = "bedrock"
  else:
    let osRelease = "/etc/os-release".loadConfig
    result = osRelease.getSectionValue("", "ID")
