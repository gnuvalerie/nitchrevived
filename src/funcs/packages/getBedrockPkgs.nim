import
  std/[strutils, osproc, sequtils]

proc getBedrockPkgs*(): string =
  var totalPkgs = 0

  try:
    let strataOutput = osproc.execCmdEx("brl list")[0]
    let strata = strataOutput.strip().split("\n").filterIt(it.len > 0)

    for stratum in strata:
      let stratumName = stratum.strip()
      if stratumName.len == 0:
        continue

      try:
        let distroOutput = osproc.execCmdEx("brl which " & stratumName)[0]
        let distroId = distroOutput.strip().toLowerAscii()

        var pkgCount = 0
        case distroId:
        of "arch", "artix", "archcraft", "manjaro", "endeavouros", "garuda":
          let archCmd = "brl strat " & stratumName & " sh -c 'ls -d /var/lib/pacman/local/* 2>/dev/null | wc -l'"
          let archResult = osproc.execCmdEx(archCmd)[0]
          pkgCount = parseInt(archResult.strip())
        of "fedora", "centos", "rhel":
          let rpmCmd = "brl strat " & stratumName & " rpm -qa 2>/dev/null | wc -l"
          let rpmResult = osproc.execCmdEx(rpmCmd)[0]
          pkgCount = parseInt(rpmResult.strip())
        of "gentoo":
          let gentooCmd = "brl strat " & stratumName & " sh -c 'ls -d /var/db/pkg/*/* 2>/dev/null | wc -l'"
          let gentooResult = osproc.execCmdEx(gentooCmd)[0]
          pkgCount = parseInt(gentooResult.strip())
        of "void":
          let voidCmd = "brl strat " & stratumName & " xbps-query -l 2>/dev/null | wc -l"
          let voidResult = osproc.execCmdEx(voidCmd)[0]
          pkgCount = parseInt(voidResult.strip())
        of "ubuntu", "debian", "pop":
          let dpkgCmd = "brl strat " & stratumName & " dpkg -l 2>/dev/null | grep '^ii' | wc -l"
          let dpkgResult = osproc.execCmdEx(dpkgCmd)[0]
          pkgCount = parseInt(dpkgResult.strip())
        of "alpine":
          let alpineCmd = "brl strat " & stratumName & " apk list --installed 2>/dev/null | wc -l"
          let alpineResult = osproc.execCmdEx(alpineCmd)[0]
          pkgCount = parseInt(alpineResult.strip())
        else:
          continue

        totalPkgs += pkgCount
      except:
        continue

  except:
    return "0"

  result = $totalPkgs
