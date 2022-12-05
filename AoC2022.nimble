# Package

version       = "0.1.0"
author        = "Hortinstein"
description   = "advent of code for nim"
license       = "MIT"

srcDir        = "src"
binDir        = "bin"

installExt    = @["nim"]
bin           = @["d1/d1","d2/d2","d3/d3", "d4/d4","d5/d5"]

# Dependencies
requires "nim >= 1.6.6"
requires "puppy"
requires "flatty"
requires "monocypher"
requires "printdebug"


task install, "Install the package":
  exec "nimble install"

