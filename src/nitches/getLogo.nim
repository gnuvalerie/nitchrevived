import
  std/terminal,
  std/tables,
  ../assets/logos

const logoMap = {
  "arch": (fgBlue, archLogo),
  "ubuntu": (fgRed, ubuntuLogo),
  "debian": (fgRed, debianLogo),
  "fedora": (fgBlue, fedoraLogo),
  "linuxmint": (fgGreen, mintLogo),
  "Zorin OS": (fgBlue, zorinLogo),
  "pop": (fgCyan, poposLogo),
  "manjaro": (fgGreen, manjaroLogo),
  "opensuse": (fgGreen, opensuseLogo),
  "slackware": (fgBlue, slackwareLogo),
  "centos": (fgYellow, centosLogo),
  "redhat": (fgRed, redhatLogo),
  "gentoo": (fgMagenta, gentooLogo),
  "endeavouros": (fgMagenta, endeavourosLogo),
  "artix": (fgBlue, artixLogo),
  "void": (fgGreen, voidLogo),
  "cachy", "cachyos": (fgGreen, cachyLogo),
  "bedrock": (fgWhite, bedrockLogo),
  "tide": (fgBlue, tideLogo),
  "freebsd": (fgRed, freebsdLogo),
  "almalinux": (fgYellow, almaLogo),
  "nixos": (fgCyan, nixosLogo),
  "steamos": (fgCyan, steamosLogo),
  "furreto": (fgMagenta, furretoLogo)
}.toTable

const defaultLogo = (fgRed, nitchLogo)

func getLogo*(distroId: string): tuple =
  logoMap.getOrDefault(distroId, defaultLogo)
