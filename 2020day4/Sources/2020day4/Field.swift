//
//  Field.swift
//  Created by Nolan Warner on 2020/12/05.
//

import Foundation

enum Field: String, CaseIterable, Equatable {
  case byr // (Birth Year)
  case iyr // (Issue Year)
  case eyr // (Expiration Year)
  case hgt // (Height)
  case hcl // (Hair Color)
  case ecl // (Eye Color)
  case pid // (Passport ID)
  case cid // (Country ID)

  static let requiredFields: [Field] = Field.allCases.filter({ $0 != .cid })

  func isValid(_ input: String) -> Bool {
    switch self {
    case .byr:
      guard let year = Int(input) else { return false }
      return 1920 <= year && year <= 2002
    case .iyr:
      guard let year = Int(input) else { return false }
      return 2010 <= year && year <= 2020
    case .eyr:
      guard let year = Int(input) else { return false }
      return 2020 <= year && year <= 2030
    case .hgt:
      if input.hasSuffix("cm") {
        guard let height = Int(input.dropLast(2)) else { return false }
        return 150 <= height && height <= 193
      } else if input.hasSuffix("in") {
        guard let height = Int(input.dropLast(2)) else { return false }
        return 59 <= height && height <= 76
      } else {
        return false
      }
    case .hcl:
      guard input.hasPrefix("#") else { return false }
      return Int(input.dropFirst(), radix: 16) != nil
    case .ecl:
      let validEyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
      return validEyeColors.contains(input)
    case .pid:
      return input.count == 9 && Int(input) != nil
    case .cid:
      return true
    }
  }
}
