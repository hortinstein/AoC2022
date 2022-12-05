import std/strutils
import std/sequtils
import std/sets

import std/algorithm

#const input = staticRead("p1input")
#https://stackoverflow.com/questions/30298950/initialize-a-seq-of-seqs
const input= """[D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"""
  
var i = 0
let lines = splitLines(input)
while i< lines.len-1:
  if lines[i].len == 0:
    break
  i+=1
let numBins =parseInt( max(lines[i-1].split(" ")))
echo numBins

var towers= seq[seq[char]]

for i2 in 0..numBins:
  towers.insert(newSeq())
  

