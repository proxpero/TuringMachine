import Files
import TuringMachine
import Foundation

guard let folder = try Folder.documents?.subfolder(named: "tur") else { fatalError() }

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

for file in folder.files where file.extension == "tur" {
    let tur = try file.readAsString()

    let machine = try Machine(tur: tur)
//    let json = try encoder.encode(machine)
//    let title = machine.title!.lowercased()
//        .replacingOccurrences(of: " ", with: "_")
//        .replacingOccurrences(of: "'", with: "")
//        .replacingOccurrences(of: "-", with: "_")
//        .replacingOccurrences(of: "(", with: "_")
//        .replacingOccurrences(of: ")", with: "_")
//        .replacingOccurrences(of: "__", with: "_")
//    print("case \(title)")
//    let _ = try folder.createFile(named: title + ".json", contents: json)
}

print("done")
