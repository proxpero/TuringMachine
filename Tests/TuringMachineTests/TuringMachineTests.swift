@testable import TuringMachine
import XCTest

struct TestError: Swift.Error {
    var message: String? = nil
}

let encoder: JSONEncoder = {
    let result = JSONEncoder()
    result.outputFormatting = [.prettyPrinted, .sortedKeys]
    return result
}()

let decoder = JSONDecoder()

enum File: String, CaseIterable {
    case binary_adder
    case binary_counter
    case binary_palindrome_decider
    case busy_beaver
    case busy_beaver_2
    case busy_beaver_3
    case copy_a_string_of_as_and_bs
    case binary_decrementer
    case dragon_curve
    case equal_number_of_0s_and_1s
    case equal_number_of_as_and_bs
    case binary_incrementer
    case multiple_of_3_decider
    case multiple_of_7_decider
    case bitwise_or
    case parenthesis_matcher
    case parity_decider
    case parity_infinity
    case power_of_2_decider
    case string_compare
    case unary_multiplier
    case unary_to_binary_converter
    case unary_to_binary_converter_faster_version_
    case universal_turing_machine
}

func loadData(forRessource name: String, withExtension ext: String?) throws -> Data {
    guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
        throw TestError(message: "Invalid name \(name)")
    }
    let data = try Data(contentsOf: url)
    return data
}

extension Machine {

    static func load(_ filename: String, withExtension ext: String? = nil) throws -> Machine {
        let data = try loadData(forRessource: filename, withExtension: ext)
        let result = try JSONDecoder().decode(Machine.self, from: data)
        return result
    }

    static func load(_ file: File) throws -> Machine {
        try load(file.rawValue, withExtension: "json")
    }
}

final class MachineTests: XCTestCase {
    func testDecodingSampleFiles() throws {
        for file in File.allCases {
            let original: Machine = try .load(file)
            let encoded = try encoder.encode(original)
            let clone = try decoder.decode(Machine.self, from: encoded)
            XCTAssertEqual(original, clone)
        }
    }
}
