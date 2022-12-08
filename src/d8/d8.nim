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
  echo red("new item checked: "& $checkHeight)  
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

proc siteLine(lineOfSight: seq[int], height: int): int=
  if (lineOfSight.len==0): return 0
  var i = 0
  while (i<lineOfSight.len):
    if (lineOfSight[i] >= height): return i+1
    i+=1
  return i

proc checkScenery(lineOfSight: seq[seq[int]], x: int, y: int): int=
  let checkHeight = trees[y][x] #rows/columns
  var col = newSeq[int]()
  for i in trees: 
    col.add(i[x])

  let lSeq = trees[y][0..x-1]
  let rSeq = trees[y][x+1..^1] 
  let uSeq = col[0..y-1]
  let dSeq = col[y+1..^1]
  
  echo "left",siteLine(lSeq,checkHeight), "right",siteLine(rSeq,checkHeight), "up",siteLine(uSeq,checkHeight), "down",siteLine(dSeq,checkHeight)
  return (siteLine(lSeq,checkHeight)*
          siteLine(rSeq,checkHeight)*
          siteLine(uSeq,checkHeight)*
          siteLine(dSeq,checkHeight) )

var visString = "" 
var maxScene = 0
var totalVis = 0
for y in 0..trees.len-1:
  for x in 0..trees[0].len-1:
    if checkVis(trees,x,y):
      totalVis+=1
      visString.add( green($trees[y][x]) )
    else:
      visString.add( grey($trees[y][x]) )
    let curScene = checkScenery(trees,x,y)
    echo curScene
    if (curScene > maxScene): maxScene = curScene
  visString.add("\n")

echo visString
echo "P1: ",totalVis
echo "P2: ",maxScene