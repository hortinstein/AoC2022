import std/strutils
import std/sequtils
import std/sets
import sequtils

import std/algorithm

const input = staticRead("p1input")
#https://stackoverflow.com/questions/30298950/initialize-a-seq-of-seqs
  
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

#create a copy for part 2
var towers2  =  towers
 
i+=1 #instruction number
while i < lines.len:
  let instruction= lines[i].split()
  let number =parseInt(instruction[1])
  let origin =parseInt(instruction[3])
  let dest = parseInt(instruction[5])
  #echo "moving ", number, " boxes from ", origin, " to ", dest
  j=0 #box counter
  #echo towers
  while j < number:
    #move the top box from origin to dest for part 1
    let move = towers[origin-1].pop()
    towers[dest-1].add(move)
    
    j+=1
  
  #move the slice of boxes
  let move = towers2[origin-1][^number..^1]#gets the slice from the origin
  for item in move:
    discard towers2[origin-1].pop() #removes items in the slide
    towers2[dest-1].add(item) #adds the items in order
  i+=1

var topString = ""
for tower in towers:
  topString.add( $tower[^1])
var topString2 = ""
for tower in towers2:
  topString2.add( $tower[^1])
  
echo "P1:",topString
echo "P2:",topString2