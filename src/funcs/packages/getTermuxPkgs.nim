import
  std/[strutils, osproc]

proc getTermuxPkgs*(): string =
  try:
    # Count installed packages using dpkg query in Termux
    let output = execCmdEx("dpkg -l | grep ^ii | wc -l")[0]
    result = output.strip()
  except:
    # Fallback to 0 if command fails
    result = "0"