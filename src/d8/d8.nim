import std/strutils
import std/sequtils
import std/sets
import std/algorithm
import "../util"

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

var visible = newSeq[seq[char]]()

proc checkVis(trees: seq[seq[int]],x: int, y: int): bool=
  let checkHeight = trees[y][x] #rows/columns
  if (x == 0 or y == 0): #check edge
    return true
  if checkHeight < trees[y][maxIndex(trees[y][0..x])]: #check left
    return true
  if checkHeight < trees[y][maxIndex(trees[y][x..^1])]: #check left
    return true
  var col = newSeq[int]()
  for i in trees: #check up
    col.add(i)
  let maxRow = maxIndex(col)
  if checkHeight < col[maxRow] and maxRow != y: #check left
    return true
  return false

var total_vis = 0
for y in 0..trees.len-1:
  for x in 0..trees[0].len-1:
    if checkVis(trees,x,y):
      total_vis+=1



echo total_vis