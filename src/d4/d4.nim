import std/strutils
import std/sequtils
import std/sets

import std/algorithm
import "../util"

type
  AssignmentPair* = object
    e1Start* : int
    e1End*: int
    e2Start*: int
    e2End*: int

proc parseLine(line: string): AssignmentPair = 
  var parts = line.split(",")
  var e1 = parts[0].split("-")
  var e2 = parts[1].split("-")
  result = AssignmentPair(
    e1Start: parseInt(e1[0]),
    e1End: parseInt(e1[1]),
    e2Start: parseInt(e2[0]),
    e2End: parseInt(e2[1])
  )
  

const input = staticRead("p1input")

var total = 0
var total2 = 0
let lines = splitLines(input)
for line in lines:
  let l = parseLine(line)
  let e1 = toHashSet(toSeq(l.e1Start..l.e1End))
  let e2 = toHashSet(toSeq(l.e2Start..l.e2End))
  if (e2 <= e1 or e1 <= e2):
    total += 1
  if (e1*e2).len > 0:
    total2 += 1
  #echo e1,e2

echo "P1:",total
echo "P2:",total2