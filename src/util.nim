import std/strutils
proc writeStringToFile*(fileName: string, contents: string) =
  let f = open(filename, fmWrite)
  f.write(contents)
  defer: f.close()

proc readStringFromFile*(fileName: string): string =
  let f = open(filename, fmRead)
  defer: f.close()
  result = f.readAll()