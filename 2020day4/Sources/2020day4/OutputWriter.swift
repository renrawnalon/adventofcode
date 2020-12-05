//
//  OutputWriter.swift
//  Created by Nolan Warner on 2020/12/05.
//

import Foundation

struct OutputWriter {
  static func write(contents: String, to file: String?) throws {
    if let file = file {
      print("Solution written to \(file)")
      try contents.write(toFile: file, atomically: true, encoding: .utf8)
    } else {
      print("Solution:\n\(contents)")
    }
  }
}
