//
//  Passport.swift
//  Created by Nolan Warner on 2020/12/05.
//

import Foundation

struct Passport {
  let fieldDictionary: [Field: String]

  var hasRequiredFields: Bool {
    Field.requiredFields.reduce(true) { (acc, next) -> Bool in
      acc && fieldDictionary.contains(where: { (key: Field, value: String) -> Bool in
        key.rawValue == next.rawValue
      })
    }
  }

  var isValid: Bool {
    Field.requiredFields.reduce(true) { (acc, next) -> Bool in
      acc && fieldDictionary.contains(where: { (key: Field, value: String) -> Bool in
        key.rawValue == next.rawValue && key.isValid(value)
      })
    }
  }
}
