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
echo getMinsAndMaxes(record)