import osproc
import os
import std/strutils
import sequtils
import algorithm

var programs = newSeq[string]()

for day in walkDir("./bin"):
  if day.path == "bin/benchmark":
    continue
  programs.add("\'"&day.path&"\'")
sort(programs)

echo programs

let cmd = "hyperfine -N --export-markdown BENCHMARKS.md " & join(programs, " ")
echo cmd
let outpShell = execProcess(cmd)
echo splitLines(outpShell)

# Define the path to the file
let filePath = "README.md"

# Use the `readFile` function to read the contents of the file
# into a string
let fileContent = readFile(filePath)

# Use the `split` function to split the string into a sequence
# of lines
var lines = fileContent.split('\n')

# remove the last benchmark
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