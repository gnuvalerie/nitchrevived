import std/[os, parsecfg, osproc]
import strutils

proc getHostname*(): string =
  let hostname = "/etc/hostname"
  let hostnameOpenrc = "/etc/conf.d/hostname"
  if hostname.fileExists():
    result = hostname.open.readLine
  elif hostnameOpenrc.fileExists():
    result = hostnameOpenrc.loadConfig.getSectionValue("", "hostname")
  elif dirExists("/data/data/com.termux/files"):  # Termux/Android environment
    # Try to get device model as hostname
    try:
      result = execCmdEx("getprop ro.product.model")[0].strip()
      if result.len == 0:
        result = "Android"
    except:
      result = "Android"
  else:
    result = ""
