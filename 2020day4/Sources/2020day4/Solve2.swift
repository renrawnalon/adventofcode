//
//  Solve2.swift
//  Created by Nolan Warner on 2020/12/05.
//

import ArgumentParser

struct Solve2: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Execute the solution to part 2 of the 2020 day 4 Advent of Code challenge",
    subcommands: []
  )

  @Option(name: .shortAndLong, parsing: .unconditional, help: "Path to the problem input file")
  private var inputFile: String

  @Option(name: .shortAndLong, parsing: .unconditional, help: "Path to which output will be written")
  private var outputFile: String?

  @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes")
  private var verbose: Bool = false

  init() { }

  func run() throws {
    let outputDestination = outputFile ?? "stdout"
    printVerbose("Reading from \(inputFile)")
    printVerbose("Outputting to \(outputDestination)")

    do {
      let rawInput = try FileReader.read(file: inputFile)
      printVerbose("Input file contents:\n\(rawInput)")

      let passports = try Parser.parse(rawInput)
      let solution1 = solve(passports: passports)
      try OutputWriter.write(contents: String(solution1), to: outputFile)
    } catch {
      print("Invalid input file!!!", error)
    }
  }

  private func solve(passports: [Passport]) -> Int {
    printVerbose("Parsed contents:")
    for passport in passports {
      printVerbose("\(passport)")
    }

    return passports.filter(\.isValid).count
  }

  private func printVerbose(_ value: String) {
    if verbose {
      print(value)
    }
  }
}
