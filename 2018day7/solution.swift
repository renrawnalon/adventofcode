#!/usr/bin/swift

import Foundation

// MARK: - Common Helper Functions

func parseInput(input: String) -> [String: Set<String>] {
  input
    .split(separator: "\n") // Get array of lines
    .map({ line -> (String, String) in
      // Parse each line into (Dependency, Step) pairs
      let words = line.split(separator: " ")
      return (String(words[1]), String(words[7]))
    })
    .reduce([:], { (acc, next) -> [String: Set<String>] in
      // Create a Step -> Dependencies map
      var acc = acc

      if acc[next.0] == nil {
        acc[next.0] = []
      }

      let oldDependencySet = acc[next.1] ?? Set()
      acc[next.1] = oldDependencySet.union([next.0])
      return acc
    })
}

// MARK: - Part One Solution

func solvePart1(file: String) -> String {
  guard let input = try? String(contentsOfFile: file) else {
    return ""
  }

  var depencencyMap = parseInput(input: input)

  var solution = ""

  while !depencencyMap.isEmpty {
    guard let nextAvailableStep = depencencyMap
      .filter({ $0.value.isEmpty })
      .sorted(by: { $0.key < $1.key })
      .first
      else { break }

    let key = nextAvailableStep.key
    solution += key
    depencencyMap[key] = nil
    depencencyMap.forEach({
      depencencyMap[$0.key] = $0.value.subtracting([key])
    })
  }

  return solution
}

// MARK: - Part Two Solution

func completionTime(forStep step: String, offset: Int = 0) -> Int {
  Int(UnicodeScalar(step)!.value) - 4 - offset // A == 65
}

typealias SIP = (step: String, startTime: Int)

func solvePart2(file: String, workerCount: Int, offset: Int = 0) -> Int {
  guard let input = try? String(contentsOfFile: file) else {
    return 0
  }

  var depencencyMap = parseInput(input: input)
  var elapsedTime = 0
  var wip: [SIP] = []

  while !depencencyMap.isEmpty {
    for sip in wip {
      let requiredTime = completionTime(forStep: sip.step, offset: offset)
      if requiredTime == elapsedTime - sip.startTime {
        let key = sip.step
        depencencyMap[key] = nil
        depencencyMap.forEach({
          depencencyMap[$0.key] = $0.value.subtracting([key])
        })
        wip = wip.filter({ $0.step != key })
      }
    }

    var nextAvailableSteps = depencencyMap
      .filter({ step in
        step.value.isEmpty && !wip.contains(where: { $0.step == step.key }) })
      .sorted(by: { $0.key > $1.key })

    while wip.count < workerCount, !nextAvailableSteps.isEmpty {
      if let nextStep = nextAvailableSteps.last {
        nextAvailableSteps = nextAvailableSteps.dropLast()
        wip += [(step: nextStep.key, startTime: elapsedTime)]
      }
    }

    elapsedTime += 1
  }

  return elapsedTime - 1
}

let solution1_simple = solvePart1(file: "./input_simple.txt")
print(solution1_simple)

let solution1 = solvePart1(file: "./input.txt")
print(solution1)

let solution2_simple = solvePart2(file: "./input_simple.txt", workerCount: 2, offset: 60)
print(solution2_simple)

let solution2 = solvePart2(file: "./input.txt", workerCount: 5)
print(solution2)
