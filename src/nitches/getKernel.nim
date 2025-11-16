import
  std/[strutils, os, osproc]

proc getKernel*(): string =
  if dirExists("/data/data/com.termux/files"):  # Termux/Android environment
    # Try to get Android kernel version
    try:
      result = readFile("/proc/version").split(" ")[2]
      # Also get Android version
      let androidVer = execCmdEx("getprop ro.build.version.release")[0].strip()
      if androidVer.len > 0:
        result = result & " (Android " & androidVer & ")"
    except:
      result = "Unknown"
  else:
    result = "/proc/version".open.readLine.split(" ")[2]
