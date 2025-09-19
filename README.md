<div align="center">

# `NiTch`

<h3>
  incredibly fast system fetch written in <code>nim👑</code>, NiTch Revived is project supposed to continue the NiTch after it become not maintained.
</h3>
<br>

![Maintenance](https://shields.io/maintenance/yes/2025?style=for-the-badge)
![Commits](https://img.shields.io/gitea/last-commit/pkgs/nitchrevived?gitea_url=https%3A%2F%2Fgit.teto.party&style=for-the-badge)

</div>

# Description 📖

`nitchrevived` is a small and incredibly fast system fetch written fully in `nim👑` without any dependencies, on my pc
it executes in around 1.70 miliseconds.

The source code of `nitchrevived` is highly documented and I hope it will act as a learning resource for nim
and linux systems architecture

If anything in the source code is unclear or is lacking in its explanation, open an issue. Sometimes you get too close to something and you fail to see the "bigger picture"!


btw written in `nim👑`

why `nim👑`? because it's fast and simple

<br>

# Installation ☁️
```fish
wget -O - https://git.teto.party/pkgs/nitchrevived/raw/branch/main/install.sh | sh
```

# Usage 🪨
```
nitchrevived
```

flags:
```
 -f --fetch   | return fetch about system
 -h --help    | return help message
 -v --version | return version of program
 -l --logo    | return fetch with specified distro logo
```

<br>

# Configuration ⚙️
### `nitch` is configured by changing the source code
### `src/funcs/drawing.nim` - config file
```nim
import
  std/terminal,     # import standard terminal lib
  std/strutils,
  getDistroId,      # import to get distro id through /etc/os-release
  ../assets/logos,  # uncomment if you use your own logo
  ../nitches/[getUser, getHostname,
                  getDistro, getKernel,
                  getUptime, getShell,
                  getPkgs, getRam, getLogo]  # import nitches to get info about user system

# the main function for drawing fetch
proc drawInfo*(asciiArt: bool, distro: string) =
  let  # distro id (arch, manjaro, debian)
    distroId = if distro.len > 0: distro else: getDistroId()

  let  # logo and it color
    coloredLogo = getLogo(distroId)  # color + logo tuple
    # (fgRed, nitchLogo)

  const  # icons before cotegores
    userIcon   = " "  # recomended: " " or "|>"
    hnameIcon  = " "  # recomended: " " or "|>"
    distroIcon = "󰻀 "  # recomended: "󰻀 " or "|>"
    kernelIcon = "󰌢 "  # recomended: "󰌢 " or "|>"
    uptimeIcon = " "  # recomended: " " or "|>"
    shellIcon  = " "  # recomended: " " or "|>"
    pkgsIcon   = "󰏖 "  # recomended: "󰏖 " or "|>"
    ramIcon    = "󰍛 "  # recomended: "󰍛 " or "|>"
    colorsIcon = "󰏘 "  # recomended: "󰏘 " or "->"
    # please insert any char after the icon
    # to avoid the bug with cropping the edge of the icon

    dotIcon = ""  # recomended: "" or "■"
    # icon for demonstrate colors

  const  # categories
    userCat   = " user   │ "  # recomended: " user   │ "
    hnameCat  = " hname  │ "  # recomended: " hname  │ "
    distroCat = " distro │ "  # recomended: " distro │ "
    kernelCat = " kernel │ "  # recomended: " kernel │ "-
    uptimeCat = " uptime │ "  # recomended: " uptime │ "
    shellCat  = " shell  │ "  # recomended: " shell  │ "
    pkgsCat   = " pkgs   │ "  # recomended: " pkgs   │ "
    ramCat    = " memory │ "  # recomended: " memory │ "
    colorsCat = " colors │ "  # recomended: " colors │ "

  let  # all info about system
    userInfo     = getUser()          # get user through $USER env variable
    hostnameInfo = getHostname()      # get Hostname hostname through /etc/hostname
    distroInfo   = getDistro()        # get distro through /etc/os-release
    kernelInfo   = getKernel()        # get kernel through /proc/version
    uptimeInfo   = getUptime()        # get Uptime through /proc/uptime file
    shellInfo    = getShell()         # get shell through $SHELL env variable
    pkgsInfo     = getPkgs(distroId)  # get amount of packages in distro
    ramInfo      = getRam()           # get ram through /proc/meminfo

  const  # aliases for colors
    color1 = fgRed
    color2 = fgYellow
    color3 = fgGreen
    color4 = fgCyan
    color5 = fgBlue
    color6 = fgMagenta
    color7 = fgWhite
    color8 = fgBlack
    color0 = fgDefault

  # ascii art
  if not asciiArt:
    discard
  else:
    stdout.styledWrite(styleBright, coloredLogo[0], coloredLogo[1], color0)

  # colored out
  stdout.styledWrite("\n", styleBright, "  ╭───────────╮\n")
  stdout.styledWrite("  │ ", color2, userIcon, color0, userCat, color1, userInfo, color0, "\n",)
  if not isEmptyOrWhitespace(hostnameInfo):
    stdout.styledWrite("  │ ", color2, hnameIcon, color0, hnameCat, color2, hostnameInfo, color0, "\n")
    stdout.styledWrite("  │ ", color3, distroIcon, color0, distroCat, color3, distroInfo, color0, "\n")
    stdout.styledWrite("  │ ", color4, kernelIcon, color0, kernelCat, color4, kernelInfo, color0, "\n")
    stdout.styledWrite("  │ ", color5, uptimeIcon, color0, uptimeCat, color5, uptimeInfo, color0, "\n")
    stdout.styledWrite("  │ ", color6, shellIcon, color0, shellCat, color6, shellInfo, color0, "\n")
    stdout.styledWrite("  │ ", color1, pkgsIcon, color0, pkgsCat, color1, pkgsInfo, color0, "\n")
    stdout.styledWrite("  │ ", color2, ramIcon, color0, ramCat, fgYellow, ramInfo, color0, "\n")
    stdout.styledWrite("  ├───────────┤\n")
    stdout.styledWrite("  │ ", color7, colorsIcon, color0, colorsCat, color7, dotIcon, " ", color1, dotIcon, " ", color2, dotIcon, " ", color3, dotIcon, " ", color4, dotIcon, " ", color5, dotIcon, " ", color6, dotIcon, " ", color8, dotIcon, color0, "\n")
    stdout.styledWrite("  ╰───────────╯\n\n")
```

# Building 📦
### 0) install [nim](https://nim-lang.org/)

### 1) clone repo
```fish
git clone https://git.teto.party/pkgs/nitchrevived
```
### 2) change dir to `nitch`
```fish
cd nitchrevived/
```

### 3) build program with `nimble`
```fish
nimble build
```
After that you will get a ready-made binary file in the root directory of the project.

<br>

# File architecture 📁
```fish
nitchrevived
├── LICENSE
├── nitchrevived
├── nitchrevived.nimble
├── README.md
└── src
    ├── assets
    │   ├── assets.nim
    │   └── logos.nim
    ├── flags
    │   └── argParser.nim
    ├── funcs
    │   ├── drawing.nim
    │   ├── packages
    │   │   ├── getPacmanPkgs.nim
    │   │   ├── getDpkgPkgs.nim
    │   │   ├── getRpmPkgs.nim
    │   │   ├── getXbpsPkgs.nim
    │   │   └── getPortagePkgs.nim
    │   └── perform.nim
    ├── nitches
    │   ├── getDistro.nim
    │   ├── getHostname.nim
    │   ├── getKernel.nim
    │   ├── getPkgs.nim
    │   ├── getRam.nim
    │   ├── getShell.nim
    │   ├── getUptime.nim
    │   └── getUser.nim
    ├── nitchrevived.nim
    └── nitchrevived.nim.cfg

7 directories, 25 files
```

# Thanks for ideas & examples 💬
- [pfetch](https://github.com/dylanaraps/pfetch/)
- [neofetch](https://github.com/dylanaraps/neofetch)
- [paleofetch](https://github.com/ss7m/paleofetch)
- [rxfetch](https://github.com/Mangeshrex/rxfetch)
- [nerdfetch](https://github.com/ThatOneCalculator/NerdFetch)
- [nitch, original](https://github.com/ssleert/nitch)
