import std/strutils
import std/algorithm
import "../util"

#let input = readStringFromFile("p1input")
const input = staticRead("p1input")

var calSeq = newSeq[int]()

var  total = 0
for line in splitLines(input):
    if line != "":
        total += parseInt(line)
    else:
        calSeq.add(total)
        total=0

echo "p1:",calSeq.max()
calSeq.sort()
let top3 = calSeq[^3..^1]
echo "p2:",top3[0]+top3[1]+top3[2] 
