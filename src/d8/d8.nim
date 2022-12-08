import std/strutils
import std/sequtils
import std/sets
import std/algorithm
import "../util"

proc green*(s: string): string = "\e[32m" & s & "\e[0m"
proc grey*(s: string): string = "\e[90m" & s & "\e[0m"
proc yellow*(s: string): string = "\e[33m" & s & "\e[0m"
proc red*(s: string): string = "\e[31m" & s & "\e[0m"

proc maxInSeq(s:seq[int]):int = 
  return s[maxIndex(s)]

const input = staticRead("p1input")
let lines = splitLines(input)
var trees = newSeq[seq[int]]()

for line in lines:
  var treeHeights = splitWhitespace(line)[0]
  var row = newSeq[int]()

  for height in treeHeights:
    let heightInt = parseInt($height)
    row.add(heightInt)
  trees.add(row)    

proc checkVis(trees: seq[seq[int]],x: int, y: int): bool=
  let checkHeight = trees[y][x] #rows/columns
  #echo red("new item checked: "& $checkHeight)  
  if (x == 0 or y == 0 or x == trees[0].len-1 or y == trees.len-1): #check edge
    #echo "corner/edge"
    return true
  #echo trees[y][0..x-1], "left"
  let lMax = maxInSeq(trees[y][0..x-1])
  #echo trees[y][x+1..^1], "right"
  let rMax = maxInSeq(trees[y][x+1..^1])
  if checkHeight > lMax: #check left
    #echo "left", lMax
    return true
  if checkHeight > rMax: #check right
    #echo "right", rMax
    return true
  var col = newSeq[int]()
  for i in trees: 
    col.add(i[x])
  let uMax = maxInSeq(col[0..y-1])
  #echo col[0..y-1], "up"
  let dMax = maxInSeq(col[y+1..^1])
  #echo col[y+1..^1],"down"
  if checkHeight > uMax: #check up
    #echo "up", uMax
    return true
  if checkHeight > dMax: #check down
    #echo "down", dMax
    return true
  return false


var visString = "" 

var total_vis = 0
for y in 0..trees.len-1:
  for x in 0..trees[0].len-1:
    if checkVis(trees,x,y):
      total_vis+=1
      visString.add( green($trees[y][x]) )
    else:
      visString.add( grey($trees[y][x]) )
  visString.add("\n")

echo visString
echo total_vis