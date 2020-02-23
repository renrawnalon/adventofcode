#!/usr/bin/swift

import Foundation

func solvePart1(file: String) -> String {
  guard let input = try? String(contentsOfFile: file) else {
    return ""
  }

  let parsedInput = input
    .split(separator: "\n")
    .map({ $0.split(separator: " ") })
    .map({ (String($0[1]), String($0[7])) })

  var depencencyMap: [String: Set<String>] = parsedInput
    .reduce([:], { (acc, next) in
      var acc = acc

      if acc[next.0] == nil {
        acc[next.0] = []
      }

      let oldDependencySet = acc[next.1] ?? Set()
      acc[next.1] = oldDependencySet.union([next.0])
      return acc
    })

  var solution = ""

  while !depencencyMap.isEmpty {
    guard let nextAvailableStep = depencencyMap.filter({ $0.value.isEmpty }).sorted(by: { $0.key < $1.key }).first else { break }

    let key = nextAvailableStep.key
    solution += key
    depencencyMap[key] = nil
    depencencyMap.forEach({ depencency in
      depencencyMap[depencency.key] = depencency.value.subtracting([key])
    })
  }

  return solution
}

let solution = solvePart1(file: "./input.txt")
print(solution)
