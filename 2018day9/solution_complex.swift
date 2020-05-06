#!/usr/bin/swift

import Foundation

// MARK: - Common Helper Functions

// MARK: - Data Types

class Game {
  let playerCount: Int
  let lastMarble: Int

  var playerScores: [Int]
  var marbles = [0]
  var currentIndex = 0

  init(playerCount: Int, lastMarble: Int) {
    self.playerCount = playerCount
    self.lastMarble = lastMarble
    self.playerScores = Array(repeating: 0, count: playerCount)
  }

  func highestScore() -> Int {
    for index in Array(0..<lastMarble) {
      addNext(marble: index + 1)
    }
    let highestScore = playerScores.reduce(0, { $0 > $1 ? $0 : $1 })
    return highestScore
  }

  private func addNext(marble: Int) {
    if marble % 23 == 0 {
      let player = (marble - 1) % playerCount
      playerScores[player] += marble
      let removingIndex = nextIndex(adding: -7)
      playerScores[player] += marbles[removingIndex]
      marbles.remove(at: removingIndex)
      currentIndex = removingIndex
      return
    }

    let next = nextIndex(adding: 2)
    marbles.insert(marble, at: next)
    currentIndex = next
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

print(Game(playerCount: 9, lastMarble: 25).highestScore())    // Expected Output: 32
print(Game(playerCount: 10, lastMarble: 1618).highestScore()) // Expected Output: 8317
print(Game(playerCount: 13, lastMarble: 7999).highestScore()) // Expected Output: 146373
print(Game(playerCount: 17, lastMarble: 1104).highestScore()) // Expected Output: 2764
print(Game(playerCount: 21, lastMarble: 6111).highestScore()) // Expected Output: 54718
print(Game(playerCount: 30, lastMarble: 5807).highestScore()) // Expected Output: 37305

let solution1 = Game(playerCount: 468, lastMarble: 71010).highestScore()
print(solution1)

print(Date())
let solution2 = Game(playerCount: 468, lastMarble: 7101000).highestScore()
print(Date())
print(solution2)
