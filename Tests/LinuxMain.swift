import XCTest

import DoubleWidthTests
import ScaleCodecTests

var tests = [XCTestCaseEntry]()
tests += DoubleWidthTests.__allTests()
tests += ScaleCodecTests.__allTests()

XCTMain(tests)
