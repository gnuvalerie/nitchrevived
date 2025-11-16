import std/[os, parsecfg]

proc getDistroId*(): string =
  if fileExists("/bedrock/strata/bedrock/etc/os-release"):
    result = "bedrock"
  elif dirExists("/data/data/com.termux/files"):
    # Detect Termux environment on Android
    result = "termux"
  else:
    let osRelease = "/etc/os-release".loadConfig
    result = osRelease.getSectionValue("", "ID")
