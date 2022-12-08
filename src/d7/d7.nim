import std/strutils
import std/sequtils
import std/sets
import std/algorithm
import "../util"

const input = staticRead("p1input")
#global variable to store the sum
var P1_SUM = 0
var TOTAL_DISK_SPACE = 70000000
var FOLDER_SIZES= newSeq[int]()
type TreeNode* = ref object
  parent: TreeNode
  contents: seq[TreeNode]
  size: int
  name: string

type FileTree* = object
    root: TreeNode

proc newFileTree*(): FileTree = 
  return FileTree(root: TreeNode(contents: @[], size: 0, name: "/"))

proc newNode(parent: TreeNode, size:int,name: string): TreeNode =
  return TreeNode(parent: parent, 
                  contents: @[], 
                  size:size,
                  name:name)

var fileSystem = newFileTree()
var curFolder = fileSystem.root  

let lines = splitLines(input)
for line in lines:
  var splitLine = splitWhitespace(line)
  if (line[0] == '$'): #command
    if ("ls" in line[0..3]):#does not need to process
      continue
    if ("$ cd " in line[0..4]): #change directory 
      if "cd /" in line:
        curFolder = fileSystem.root #change back to root
      elif "cd .." in line:
        if curFolder.parent != nil: #ensure its not root
          curFolder = curFolder.parent #assign it to root
      else:
        for item in curFolder.contents:
          #gets the name and ensures its not a folder
          if item.name == splitLine[2]:
            curFolder = item
            break         
  elif ("dir" in line[0..3]): #directory listing
    curFolder.contents.add(newNode(curFolder,0,splitLine[1]))
  else: #file
    let size = splitLine[0].parseInt
    let name = splitLine[1]
    curFolder.contents.add(newNode(curFolder,size,name))

proc printTree(node: TreeNode,path:string): int = 
  var totalSize = 0
  for item in node.contents:
    if item.size == 0:
      totalSize += printTree(item, path & item.name & "/")
    else:
      totalSize += item.size
  #echo path , " ", totalSize
  if totalSize < 100000:
    P1_SUM+=totalSize
  FOLDER_SIZES.add(totalSize)
  return totalSize


let TOTAL_USAGE = printTree(fileSystem.root, fileSystem.root.name)

FOLDER_SIZES.sort()

let UNUSED = TOTAL_DISK_SPACE - TOTAL_USAGE
let NEEDED = 30000000
echo "UNUSED: ", UNUSED
echo "NEEDED: ", NEEDED
let TOFREE = NEEDED - UNUSED
echo "TOFREE ": TOFREE
echo "P1: ", P1_SUM

for i in FOLDER_SIZES:
  if i > TOFREE:
    echo "P2: ", i
    break