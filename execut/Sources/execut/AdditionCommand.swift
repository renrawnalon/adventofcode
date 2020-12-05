import Foundation
import Utility
import Basic

struct AdditionCommand: Command {

    let command = "add"
    let overview = "Compute the sum of all the numbers."

    private let numbers: PositionalArgument<[Int]>

    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numbers = subparser.add(positional: "numbers", kind: [Int].self,
                                usage: "List of numbers to operate with.")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        guard let integers = arguments.get(numbers) else {
            return
        }
        let result = integers.reduce(0, +)
        print(result)
    }

}
