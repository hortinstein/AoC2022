import osproc
import os
import std/strutils
import sequtils
import algorithm

var programs = newSeq[string]()

for day in walkDir("./bin"):
  #skips benchmark since recursive lol
  if day.path == "bin/benchmark": 
    continue
  programs.add("\'"&day.path&"\'")

#sorts it so it's in the days order
sort(programs)

#uses hyperfine to benchmark the programs
let cmd = "hyperfine -N --export-markdown BENCHMARKS.md " & join(programs, " ")
let outpShell = execProcess(cmd)
echo splitLines(outpShell)

let filePath = "README.md"
let fileContent = readFile(filePath)
var lines = fileContent.split('\n')

# go till the last benchmark and ditch the rest
var i = 0
var preAmble = ""
while i < lines.len:
  preAmble.add(lines[i]&"\n")
  if "Benchmark" in lines[i]:
    break
  i += 1
  
# Use the `writeFile` function to write the modified
# contents of the file back to the original file
writeFile(filePath, preAmble)

#append the benchmarks
let outpShell2 = execProcess("cat BENCHMARKS.md >> README.md")