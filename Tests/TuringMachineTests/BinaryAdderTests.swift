@testable import TuringMachine
import XCTest

final class BinaryAdderTests: XCTestCase {
    func testBinaryAdder() throws {
        let samples: [(String, Int, String)] = [
            ("1 0 1 0 + 1 1 1 1", 0, "11001"),
            ("1 0 0 + 1 1 1", 0, "1011"),
            ("1 1 0 0 + 1 1", 0, "1111"),
            ("1 0 1 0 + 1 0 0 1 0 1", 0, "101111"),
        ]

        for (tape, index, expectation) in samples {
            var adder: Machine = try .load(.binary_adder)
            try adder.loadTape(tape, startIndex: index)
            adder.run()
            let result = adder.tape.prefix(while: { $0 != adder.blank }).joined()
            XCTAssertEqual(result, expectation)
        }
    }
}
