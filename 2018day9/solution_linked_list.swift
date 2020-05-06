#!/usr/bin/swift

import Foundation

// MARK: - Common Helper Functions

// MARK: - Data Types

class Node: NSObject {
  let value: Int
  private var next: Node?
  private var previous: Node?

  init(value: Int) {
    self.value = value
  }

  func inserting(_ value: Int) -> Node {
    let newNode = Node(value: value)
    let next = self.next ?? self
    next.previous = newNode
    self.next = newNode
    newNode.previous = self
    newNode.next = next

    return newNode
  }

  func removing() -> Node {
    let next = self.next ?? self
    let previous = self.previous ?? self
    next.previous = previous
    previous.next = next

    return next
  }

  func getNode(moving count: Int) -> Node {
    var node = self
    if count >= 0 {
      for _ in Array(0..<count) {
        node = node.next ?? node
      }
    } else {
      for _ in Array(0..<(-count)) {
        node = node.previous ?? node
      }
    }
    return node
  }

  func printAll() {
    let first = self
    var next = self
    var values: [Int] = []
    repeat {
      values += [next.value]
      next = next.next ?? next
    } while next !== first

    print(values.map({ String($0) }).joined(separator: ","))
  }

  override var description: String {
    "\(value)"
  }
}

class Game {
  private let playerCount: Int
  private let lastMarble: Int

  private(set) var highScore: Int = 0
  private(set) var runTime: TimeInterval = 0

  private var playerScores: [Int]
  private var marbles = [0]
  private var currentIndex = 0
  private var currentMarble = Node(value: 0)

  init(playerCount: Int, lastMarble: Int) {
    self.playerCount = playerCount
    self.lastMarble = lastMarble
    self.playerScores = Array(repeating: 0, count: playerCount)
  }

  func runGame() -> Game {
    let startDate = Date()
    for index in Array(0..<lastMarble) {
      addNext(marble: index + 1)
    }
    highScore = playerScores.reduce(0, { $0 > $1 ? $0 : $1 })
    runTime = Date().timeIntervalSince(startDate)
    return self
  }

  func printResults(withTitle title: String) {
    print("\(title): \(highScore), Run Time: \(Int(runTime * 1000))ms")
  }

  private func addNext(marble: Int) {
    if marble % 23 == 0 {
      let player = (marble - 1) % playerCount
      playerScores[player] += marble
      let next = currentMarble.getNode(moving: -7)
      playerScores[player] += next.value
      currentMarble = next.removing()
      return
    }

    let next = currentMarble.getNode(moving: 1)
    currentMarble = next.inserting(marble)
    //    currentMarble.printAll()
  }

  private func nextIndex(adding value: Int) -> Int {
    var nextIndex = currentIndex + value
    if nextIndex > marbles.count {
      nextIndex -= marbles.count
    }
    if nextIndex < 0 {
      nextIndex += marbles.count
    }
    return nextIndex
  }
}

// MARK: - Execute solutions

Game(playerCount: 9, lastMarble: 25).runGame().printResults(withTitle: "Sample 1")    // Expected Output: 32
Game(playerCount: 10, lastMarble: 1618).runGame().printResults(withTitle: "Sample 2") // Expected Output: 8317
Game(playerCount: 13, lastMarble: 7999).runGame().printResults(withTitle: "Sample 3") // Expected Output: 146373
Game(playerCount: 17, lastMarble: 1104).runGame().printResults(withTitle: "Sample 4") // Expected Output: 2764
Game(playerCount: 21, lastMarble: 6111).runGame().printResults(withTitle: "Sample 5") // Expected Output: 54718
Game(playerCount: 30, lastMarble: 5807).runGame().printResults(withTitle: "Sample 6") // Expected Output: 37305

Game(playerCount: 468, lastMarble: 71010).runGame().printResults(withTitle: "Solution 1")
Game(playerCount: 468, lastMarble: 7101000).runGame().printResults(withTitle: "Solution 2")
