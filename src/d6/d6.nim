import std/strutils
import std/sequtils
import std/sets
import sequtils

import std/algorithm

const input = staticRead("p1input")

proc parseLine(input: string,diff_count:int): int = 
  let real_diff = diff_count-1 # takes one off from the argment to match the problem since we are counting from zero
  var i = 0
  while i  < input.len:
    var diffcount= 0
    for c in input[i..i+real_diff]:
      if ( count(input[i..i+real_diff],c) > 1):
        break
      else:
        diffcount+=1
      if diffcount == real_diff:  
        return i+diff_count+1
    i+=1
assert(parseLine("bvwbjplbgvbhsrlpgdmjqwftvncz",4) == 5) #: first marker after character 5
assert(parseLine("nppdvjthqldpwncqszvftbrmjlhg",4) == 6) #: first marker after character 6
assert(parseLine("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",4)==10) #: first marker after character 10
assert(parseLine("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",4)== 11) #: first marker after character 11

echo "P1: ",parseLine(input,4)
echo "P2: ",parseLine(input,14)