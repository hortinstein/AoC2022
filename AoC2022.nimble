# Package

version       = "0.1.0"
author        = "Hortinstein"
description   = "advent of code for nim"
license       = "MIT"

srcDir        = "src"
binDir        = "bin"

installExt    = @["nim"]

namedBin = {"d1/d1": "d1", 
            "d2/d2": "d2", 
            "d3/d3": "d3", 
            "d4/d4": "d4",
            "d5/d5": "d5",
            "d6/d6": "d6"}.toTable()

# Dependencies
requires "nim >= 1.6.6"

task install, "Install the package":
  exec "nimble install"

