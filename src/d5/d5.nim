import std/strutils
import std/sequtils
import std/sets

import std/algorithm

#const input = staticRead("p1input")
#https://stackoverflow.com/questions/30298950/initialize-a-seq-of-seqs
const input= """    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"""
  
#finds the index of the line where instructions start
var i = 0
let lines = splitLines(input)
while i< lines.len-1:
  if lines[i].len == 0:
    break
  i+=1
  
#gets the number of bins.
let numBins =parseInt( max(lines[i-1].split(" ")))
echo numBins

#creates a sequence of sequences
var towers = newSeq[seq[char]]()

#creates a new seq for each tower in the input
for tower in 0..numBins-1:
  var row = newSeq[char]()
  towers.insert(row)
  
#translates the ascii diagram into data structure representation....messily
var curTower = 0
var j=i-1
while j>0:
  #echo lines[j]
  j-=1
  var k = 0
  var curTower =0
  while k+2<lines[j].len:
    #echo lines[j][k..k+2], "*"
    
    if lines[j][k+1] != ' ':
      towers[curTower].add(lines[j][k+1])
    k+=4
    curTower+=1
#echo towers

i+=1 #instruction number
while i < lines.len:
  let instruction= lines[i].split()
  let number =parseInt(instruction[1])
  let origin =parseInt(instruction[3])
  let dest = parseInt(instruction[5])
  echo "moving ", number, " boxes from ", origin, " to ", dest
  j=0 #box counter
  echo towers
  while j < number:
    let move = towers[origin-1].pop()
    towers[dest-1].add(move)
    echo towers
    j+=1
  i+=1

var topString = ""
for tower in towers:
  topString.add( $tower[^1])
  
echo topString
