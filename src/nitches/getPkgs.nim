import
  ../funcs/packages/[getPacmanPkgs, getRpmPkgs,
                     getPortagePkgs, getXbpsPkgs,
                     getDpkgPkgs, getBpmPkgs,
                     getNixPkgs, getBedrockPkgs]
import strutils

proc getPkgs*(distroId: string): string =
  let normalizedId = distroId.toLowerAscii()
  case normalizedId:
  of "arch", "artix", "archcraft", "manjaro", "endeavouros", "garuda", "steamos", "furreto":
    result = getPacmanPkgs()
  of "fedora":
    result = getRpmPkgs()
  of "gentoo":
    result = getPortagePkgs()
  of "void":
    result = getXbpsPkgs()
  of "ubuntu", "debian", "pop":
    result = getDpkgPkgs()
  of "tide":
    result = getBpmPkgs()
  of "nixos":
    result = getNixPkgs()
  of "bedrock":
    result = getBedrockPkgs()
  else:
    result = "0"

  try:
    discard parseInt(result)
  except ValueError:
    result = "0"
