import std/strutils
import std/sequtils
import std/sets

import std/algorithm
import "../util"

const input = staticRead("p1input")


type TreeNode* = ref object
  parent: TreeNode
  contents: seq[TreeNode]
  size: int
  name: string

type FileTree* = object
    # Object representing an AVL tree
    root: TreeNode

proc newNode(parent: TreeNode, size:int,name: string): ref TreeNode =
  return new TreeNode(parent: parent, 
                  contents: @[], 
                  size:size,
                  name:name)

proc newFileTree*(): FileTree = 
  return FileTree(root: TreeNode(contents: @[], size: 0, name: "/"))

var fileSystem = newFileTree()
var context = ref TreeNode 
context = fileSystem.root  

let lines = splitLines(input)
for line in lines:
  if (line[0] == '$'): #command
    echo "COMMAND: ",line
    if ("ls " in line):#does not need to process
      continue
    if ("cd " in line): #change directory 
      if "cd /" in line:
        echo "chroot"        

  elif ("dir" in line[0..3]): #directory listing
    echo "DIR: ",line
  else: #file
    echo "FILE: ",line