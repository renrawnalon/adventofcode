//
//  Parser.swift
//  Created by Nolan Warner on 2020/12/05.
//

import Foundation

struct Parser {
  enum ParserError: Error {
    case invalidPair
    case invalidField
  }

  static func parse(_ input: String) throws -> [Passport] {
    try input
      .components(separatedBy: .newlines)
      .reduce([[:]]) { (acc, next) -> [[Field: String]] in
        if next.isEmpty {
          return acc + [[:]]
        }

        var acc = acc
        acc[acc.count - 1].merge(try parsePairs(next)) { (lhs, rhs) -> String in
          lhs
        }
        return acc
      }
      .filter({ !$0.isEmpty })
      .map({ Passport(fieldDictionary: $0) })
  }

  private static func parsePairs(_ input: String) throws -> [Field : String] {
    try input
      .components(separatedBy: .whitespacesAndNewlines)
      .reduce([:]) { (acc, next) -> [Field: String] in
        var acc = acc
        let pair = next.split(separator: ":")
        guard pair.count == 2 else {
          throw ParserError.invalidPair
        }
        guard let field = Field(rawValue: String(pair[0])) else {
          throw ParserError.invalidField
        }
        acc[field] = String(pair[1])
        return acc
      }
  }
}
