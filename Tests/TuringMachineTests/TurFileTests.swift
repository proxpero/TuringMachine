@testable import TuringMachine
import XCTest

final class TurFileTests: XCTestCase {

    func load(filename: String) throws -> String {
        let data = try loadData(forRessource: filename, withExtension: "tur")
        let result = String(decoding: data, as: UTF8.self)
        return result
    }

    func testBinaryAdderTurDecoder() throws {
        let string = try load(filename: "binaryadder")
        let result: Machine? = try .init(tur: string)
        let expectation: Machine = try .load("BinaryAdder", withExtension: "json")
        XCTAssertEqual(result, expectation)
    }

    func testBusyBeaver2TurDecoder() throws {
        let string = try load(filename: "busybeaver2")
        let result: Machine? = try .init(tur: string)
    }

    func testMult3TurDecoder() throws {
        let string = try load(filename: "mult3")
        let result: Machine? = try .init(tur: string)
    }
}
