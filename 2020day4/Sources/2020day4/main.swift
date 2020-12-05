import ArgumentParser

struct Go: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Execute the solution to the 2020 day 4 Advent of Code challenge")

  @Option(name: .shortAndLong, parsing: .unconditional, help: "Path to the problem input file")
  private var inputFile: String

  @Option(name: .shortAndLong, parsing: .unconditional, help: "Path to which output will be written")
  private var outputFile: String?

  @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes")
  private var verbose: Bool = false

  init() { }

  func run() throws {
    if verbose {
      print(inputFile)
      print(String(describing: outputFile))
    }
  }
}

Go.main()
