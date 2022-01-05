extension Machine: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case start
        case states
        case transitions
        case blank
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        let start = try container.decode(Int.self, forKey: .start)

        let blank = try container.decode(String.self, forKey: .blank)
        let statesArray = try container.decode([String].self, forKey: .states)
        let transitionsArray = try container.decode([String].self, forKey: .transitions)

        func state(in string: String) throws -> State {
            let items = string.split(separator: " ")
            guard items.count == 2,
                  let id = items.first,
                  let move = items.last
            else {
                throw Machine.Error.invalidFileFormat("Invalid state \(string) in \(title ?? "Untitled")")
            }
            
            return State(id: String(id), move: .init(stringLiteral: String(move)))
        }

        let states: [State] = try statesArray.map(state(in:))
        let dictionary = states.reduce(into: [:]) { $0[$1.id] = $1 }

        let store: [Transitions.Key: Transitions.Value] = try transitionsArray.reduce(into: [:]) { result, entry in
            let items = entry.split(separator: " ").map(String.init)
            guard items.count == 4,
                  let startState = dictionary[items[0]],
                  let nextState = dictionary[items[1]]
            else {
                throw Machine.Error.invalidFileFormat("Invalid store item \(items) in \(title ?? "Untitled")")
            }
            result[.init(node: startState, symbol: items[2])] = .init(nextNode: nextState, writeSymbol: items[3])
        }

        let transitions = Transitions(store: store)

        self = .init(
            title: title,
            description: description,
            start: states[start],
            blank: blank,
            transitions: transitions
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let title = title {
            try container.encode(title, forKey: .title)
        }
        if let description = description {
            try container.encode(description, forKey: .description)
        }
        let states = transitions.states.sorted(by: { $0.id < $1.id })

        guard let startIndex = states.firstIndex(of: startState) else {
            throw Machine.Error.startNotContainedInStates
        }

        try container.encode(states.map { "\($0.id) \($0.move.rawValue)" }, forKey: .states)
        try container.encode(startIndex, forKey: .start)
        try container.encode(blank, forKey: .blank)

        let array = transitions.store.map {
            "\($0.key.node.id) \($0.value.nextNode.id) \($0.key.symbol) \($0.value.writeSymbol)"
        }.sorted()
        try container.encode(array.sorted(), forKey: .transitions)
    }
}
