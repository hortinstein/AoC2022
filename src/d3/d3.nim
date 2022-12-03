import std/strutils
import std/sets

import std/algorithm
import "../util"

proc returnValue(c: char): int =
  if c in 'a'..'z':
    return ord(c) - ord('a') + 1
  else:
    return ord(c) - ord('A') + 27


#test cases from the problem
assert(16 == returnValue('p'))
assert(38 == returnValue('L'))
assert (42 == returnValue('P')) 
assert (22 == returnValue('v'))
assert (20 == returnValue('t'))
assert (19 == returnValue('s'))

const input = staticRead("p1input")
var total = 0
for line in splitLines(input):
  let halflen = int(line.len/2)
  let h1 = toHashSet(line[0..halflen-1])
  let h2 = toHashSet(line[halflen..^1])
  var intersection = (h1*h2) #gets the intersection of the two sets
  total+= returnValue(intersection.pop) 
echo "P1:",total

total = 0
var i = 0
while i < splitLines(input).len:
  let lines = splitLines(input)
  let e1 = toHashSet(lines[i])
  let e2 = toHashSet(lines[i+1])
  let e3 = toHashSet(lines[i+2])
  var intersection = (e1*e2*e3)
  #echo intersection
  total+= returnValue(intersection.pop)
  i+=3

echo "P2:",total
