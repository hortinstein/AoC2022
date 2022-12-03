import std/strutils
import std/algorithm
import "../util"
const input = staticRead("p1input")

const ROCK = 1
const PAPER = 2
const SCISSORS = 3

  
proc getWinner(a,b: int): int =
  if a == b:
    return 3
  elif a == ROCK and b == PAPER:
    return 0
  elif a == ROCK and b == SCISSORS:
    return 6
  elif a == PAPER and b == ROCK:
    return 6
  elif a == PAPER and b == SCISSORS:
    return 0
  elif a == SCISSORS and b == ROCK:
    return 0
  elif a == SCISSORS and b == PAPER:
    return 6

proc getMove(throws: char, a: openArray[char]): int =
  for i in 0..a.len-1:
    if a[i] == throws:
      return i+1
  return 
proc getMoveP2(throws: char, theirMove: char,them: openArray[char]): int =
  # X means you need to lose,
  # Y means you need to end the round in a draw
  # Z means you need to win"
  if throws == 'Z':
    if (getMove(theirMove,them)+1 == 4):
      return 1
    else:
      return (getMove(theirMove,them)+1)
  if throws == 'Y':
    return getMove(theirMove,them)
  if throws == 'X':
    if (getMove(theirMove,them)-1 == 0):
      return 3
    else:
      return (getMove(theirMove,them)-1)

  return 

const them = ['A','B','C']
const you = ['X','Y','Z']
const moves = [ROCK,PAPER,SCISSORS]


var p1Total,p2Total = 0
for line in splitLines(input):
  let yourmove = line.split()[1]
  let theirmove =  line.split()[0]
  let p1WinScore = getWinner(getMove(yourmove[0],you),getMove(theirmove[0],them))
  let p1TotalScore = p1WinScore + getMove(yourmove[0],you) 
  p1Total += p1TotalScore
  
  let p2WinScore = getWinner(getMoveP2(yourmove[0],theirmove[0],them),getMove(theirmove[0],them))
  echo p2WinScore, " ",getMoveP2(yourmove[0],theirmove[0],them)
  let p2TotalScore = p2WinScore + getMoveP2(yourmove[0],theirmove[0],them)
  p2Total += p2TotalScore



echo "P1:",p1Total
echo "P2:",p2Total