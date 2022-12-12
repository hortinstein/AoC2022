import std/strutils
import std/sequtils
import std/sets

import std/algorithm
import "../util"

type CoordPair* = object
  x: int
  y: int

type CoordRecord = ref object
  hHist: seq[CoordPair]
  tHist: seq[CoordPair]

proc printBoard(x: int, y: int, rows:int, columns:int,startx:int,starty:int) =
  var boardState = ""
  var i = rows
  while i >= 0:
    for j in 0..columns:
      if i == y and j == x:
        boardState.add("X")
      elif i == startx and j == starty:
        boardState.add("S")
      else:
        boardState.add(".")
    boardState.add("\n")
    i -= 1
  echo boardState
  
proc getMinsAndMaxes(record: CoordRecord): (CoordPair, CoordPair) =
  var minX = 0
  var minY = 0
  var maxX = 0
  var maxY = 0
  for coord in record.hHist:
    if coord.x < minX:
      minX = coord.x
    if coord.x > maxX:
      maxX = coord.x
    if coord.y < minY:
      minY = coord.y
    if coord.y > maxY:
      maxY = coord.y
  return (CoordPair(x: minX, y: minY), CoordPair(x: maxX, y: maxY))


proc hGoRight(record: CoordRecord, num: int) =
  for i in 0..num:
    record.hHist.add(CoordPair(x: record.hHist[^1].x + 1, y: record.hHist[^1].y))

proc hGoLeft(record: CoordRecord, num: int) = 
  for i in 0..num:
    record.hHist.add(CoordPair(x: record.hHist[^1].x - 1, y: record.hHist[^1].y))

proc hGoDown(record: CoordRecord, num: int) = 
  for i in 0..num:
    record.hHist.add(CoordPair(x: record.hHist[^1].x - 1, y: record.hHist[^1].y-1))

proc hGoUp(record: CoordRecord, num: int) = 
  for i in 0..num:
    record.hHist.add(CoordPair(x: record.hHist[^1].x, y: record.hHist[^1].y+1))

const input = staticRead("p1input")

let lines = splitLines(input)

var record = CoordRecord(hHist: @[CoordPair(x: 0, y: 0)])
for line in lines:
  if line.len == 0: break 
  let dir = line.split(" ")[0]
  let ammount = parseInt(line.split(" ")[1])
  echo dir, " ", ammount
  if dir == "R":
    hGoRight(record, ammount)
  elif dir == "L":
    hGoLeft(record, ammount)
  elif dir == "U":
    hGoUp(record, ammount)
  elif dir == "D":
    hGoDown(record, ammount)
  else:
    echo "Error"
    break

echo record.hHist
let (lowest,highest) = getMinsAndMaxes(record)
let rows = abs(lowest.y) + abs(highest.y)
let columns = abs(lowest.x) + abs(highest.x)
var startx = record.hHist[0].x+abs(highest.x)
var starty = record.hHist[0].y+abs(highest.y)
for record in record.hHist:
  printBoard( record.x+abs(lowest.x), 
              record.y+abs(lowest.y), 
              rows, 
              columns,
              startx,
              starty) 