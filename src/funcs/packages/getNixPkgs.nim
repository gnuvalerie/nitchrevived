import std/[os, osproc, strutils]
import sequtils

proc getNixPkgs*(): string =
  var pkgs: seq[string] = @[]
  let paths =
    @[
      "~/.nix-profile", # User installed
      "/etc/profiles/per-user/" & os.getEnv("USER"), # User installed
      "/nix/var/nix/profiles/default", # Default
      "/run/current-system/sw", # System installed
    ]
  for path in paths:
    var packages: string
    try:
      packages = osproc.execCmdEx("nix-store -q -R " & path)[0]
    except:
      continue
    for pkg in packages.split("\n"):
      pkgs.add(pkg)
  # Deduplicate list
  pkgs = pkgs.toSeq().deduplicate()
  return $(pkgs.len - 1)
