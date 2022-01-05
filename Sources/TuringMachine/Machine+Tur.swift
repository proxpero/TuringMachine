extension Machine {
    public init(tur: String) throws {

        var title: String
        var description: String
        var transitions: Transitions
        var blank: Symbol = "#"

        var lines = tur
            .split(separator: "\n")
            .map { String($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            .filter({ !$0.isEmpty })

        guard lines.removeFirst() == "title" else {
            throw Machine.Error.invalidFileFormat("No Title in \(tur)")
        }

        title = String(lines.removeFirst())

        lines.removeFirst() // "Description"
        var desc: [String] = []
        while lines.first != "vertices" && lines.first != "fill symbol" {
            desc.append(lines.removeFirst())
        }
        description = desc.joined(separator: " ")

        guard !description.isEmpty else {
            throw Machine.Error.invalidFileFormat("No Description in \(tur)")
        }

        if lines.first == "fill symbol" {
            lines.removeFirst()
            blank = String(lines.removeFirst())
        }

        guard lines.removeFirst() == "vertices" else {
            throw Machine.Error.invalidFileFormat("No Vertices in \(tur)")
        }

        var states: [State] = []
        while lines.first != "edges" {
            let next = lines.removeFirst()
            let items = next.split(separator: " ").prefix(2)
            guard let id = items.first,
                  let rawValue = items.last
            else {
                throw Machine.Error.invalidFileFormat("Invalid Vertex \(next) in \(tur)")
            }
            let move = Move(rawValue: String(rawValue)) ?? .halt(.accept)
            let state = State(id: String(id), move: move)
            states.append(state)
        }

        guard !states.isEmpty else {
            throw Machine.Error.invalidFileFormat("States is empty in \(tur)")
        }

        guard lines.removeFirst() == "edges" else {
            throw Machine.Error.invalidFileFormat("No Edges in \(tur)")
        }

        let dictionary = states.reduce(into: [:]) { $0[$1.id] = $1 }
        var store: [Transitions.Key: Transitions.Value] = [:]
        while !lines.isEmpty && lines.first != "tapes" {
            let next = lines.removeFirst()
            let items = next.split(separator: " ").prefix(4)
            guard items.count == 4 else {
                throw Machine.Error.invalidFileFormat("In valid edge count \(next) in \(tur)")
            }
            let sid = String(items[0])
            let nid = String(items[1])
            let cur = String(items[2])
            let wri = String(items[3])

            guard let s = dictionary[sid],
                  let n = dictionary[nid]
            else {
                throw Machine.Error.invalidFileFormat("Invalid states \(next) in \(tur)")
            }

            store[.init(node: s, symbol: cur)] = .init(nextNode: n, writeSymbol: wri)
        }
        guard !store.isEmpty else {
            throw Machine.Error.invalidFileFormat("Empty edges in \(tur)")
        }

        transitions = .init(store: store)

        self = .init(
            title: title,
            description: description,
            start: states[0],
            blank: blank,
            transitions: transitions
        )
    }
}
