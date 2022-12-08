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

proc checkVis(trees: newSeq[seq[int]],x: int, y: int): bool=
  let checkHeight = newSeq[y][x] #rows/columns ;(
  if (x == 0 or y == 0): #check edge
    return true
  if checkHeight < trees[y][maxIndex(trees[y](0..x))]: #check left
    return true
  if checkHeight < trees[y][maxIndex(trees[y](x..^1))]: #check left
    return true
  var col = newSeq[int]()
  for i in trees: #check up
    col.add(i)
  maxRow = maxIndex(col)
  if checkHeight < col[maxRow] and maxRow != y: #check left
    return true


for i in 0..trees.len-1:
  for j in 0..trees[0].len-1:
    


