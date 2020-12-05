//
//  FileReader.swift
//  Created by Nolan Warner on 2020/12/05.
//

import Foundation

struct FileReader {
  static func read(file: String) throws -> String {
    try String(contentsOfFile: file)
  }
}
