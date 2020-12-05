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
}
