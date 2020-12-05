import ArgumentParser

struct Advent: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Execute the solutions to the 2020 day 4 Advent of Code challenge",
    subcommands: [Solve1.self]
  )

  init() { }
}

Advent.main()
