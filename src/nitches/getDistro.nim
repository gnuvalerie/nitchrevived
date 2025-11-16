import std/[os, parsecfg]

proc getDistro*(): string =
  if fileExists("/bedrock/strata/bedrock/etc/os-release"):
    result = "bedrock"
  elif dirExists("/data/data/com.termux/files"):
    result = "Termux"
  else:
    result = "/etc/os-release".loadConfig.getSectionValue("", "PRETTY_NAME")
