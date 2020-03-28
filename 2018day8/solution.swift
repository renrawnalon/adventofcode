#!/usr/bin/swift

import Foundation

// MARK: - Common Helper Functions

func readInput(file: String) -> String? {
  try? String(contentsOfFile: file)
}

extension Array {
  subscript(safe index: Int) -> Element? {
    guard 0 <= index && index < count else { return nil }
    return self[index]
  }
}

// MARK: - Parsing

struct Node {
  let metadata: [Int]
  let children: [Node]

  // Part 1 solution
  func sum() -> Int {
    metadata.reduce(0, +) + children.map({ $0.sum() }).reduce(0, +)
  }

  // Part 2 solution
  func value() -> Int {
    guard !children.isEmpty else { return metadata.reduce(0, +) }

    return metadata.compactMap({ children[safe: $0 - 1]?.value() ?? 0 }).reduce(0, +)
  }
}

func parseInput(input: String) -> Node {
  let intArray = input.split(separator: "\n")[0].split(separator: " ").compactMap({ Int($0) })

  guard intArray.count >= 2 else { return Node(metadata: [], children: []) }

  let output = parseNode(childCount: intArray[0], metadataCount: intArray[1], sublist: Array(intArray.dropFirst(2)))

  return output.0
}

func parseNode(childCount: Int, metadataCount: Int, sublist: [Int]) -> (Node, [Int]) {
  var outputList = sublist
  var children: [Node] = []

  for _ in (0..<childCount) {
    let output = parseNode(childCount: outputList[0], metadataCount: outputList[1], sublist: Array(outputList.dropFirst(2)))
    outputList = output.1
    children.append(output.0)
  }

  let node = Node(
    metadata: Array(outputList.prefix(metadataCount)),
    children: children
  )
  let remainder = Array(outputList.dropFirst(metadataCount))

  return (node, remainder)
}

// MARK: - Part One Solution

func solvePart1(file: String) -> Int {
  guard let input = readInput(file: file) else { return 0 }

  return parseInput(input: input).sum()
}

// MARK: - Part Two Solution

func solvePart2(file: String) -> Int {
  guard let input = readInput(file: file) else { return 0 }

  return parseInput(input: input).value()
}

// MARK: - Execute solutions

let solution1_sample = solvePart1(file: "./input_sample.txt")
print(solution1_sample)

let solution1 = solvePart1(file: "./input.txt")
print(solution1)

let solution2_sample = solvePart2(file: "./input_sample.txt")
print(solution2_sample)

let solution2 = solvePart2(file: "./input.txt")
print(solution2)
