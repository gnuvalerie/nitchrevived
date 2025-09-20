import std/[os, parsecfg]

proc getDistro*(): string =
  if fileExists("/bedrock/strata/bedrock/etc/os-release"):
    result = "bedrock"
  else:
    result = "/etc/os-release".loadConfig.getSectionValue("", "PRETTY_NAME")
