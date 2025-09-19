func argParser*(args: seq[string], argCount: int): uint8 =
  const
    argsList: array[8, string] = [
    "-a", "--no-ascii",
    "-h", "--help",
    "-v", "--version",
    "-l", "--logo"
    ]

  if argCount == 0:
    result = 0
  else:
    case args[0]:
    of argsList[0..1]:
      result = 1
    of argsList[2..3]:
      result = 2
    of argsList[4..5]:
      result = 3
    of argsList[6..7]:
      if argCount >= 2:
        result = 4
      else:
        result = 0
    else:
      result = 0
