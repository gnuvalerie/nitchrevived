import
  std/[strutils, osproc, sequtils]

proc getBedrockPkgs*(): string =
  var totalPkgs = 0

  try:
    let strataOutput = osproc.execCmdEx("brl list")[0]
    let strata = strataOutput.strip().splitLines().filterIt(it.len > 0)
    let realStrataCount = max(strata.len - 1, 0) # exclude 'bedrock' itself

    try:
      let pkgOut = osproc.execCmdEx("pmm list --installed")[0]
      let pkgCount = pkgOut.strip().splitLines().len
      totalPkgs = pkgCount - realStrataCount
    except:
      return "0"

  except:
    return "0"

  result = $totalPkgs

