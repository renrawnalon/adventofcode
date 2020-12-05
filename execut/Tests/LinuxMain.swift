import XCTest

import executTests

var tests = [XCTestCaseEntry]()
tests += executTests.allTests()
XCTMain(tests)
