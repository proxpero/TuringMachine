public struct Transitions: Equatable {
    struct Key: Hashable {
        let node: State
        let symbol: Symbol
    }

    struct Value: Equatable {
        let nextNode: State
        let writeSymbol: Symbol
    }

    var store: [Key: Value]

    subscript(node: State, current: Symbol) -> (State, Symbol)? {
        guard let result = store[.init(node: node, symbol: current)] else { return nil }
        return (result.nextNode, result.writeSymbol)
    }
}

extension Transitions {

    var states: Set<State> {
        store.reduce(into: Set<State>()) { result, transition in
            result.insert(transition.key.node)
            result.insert(transition.value.nextNode)
        }
    }

    var symbols: Set<Symbol> {
        store.reduce(into: Set<Symbol>()) { result, transition in
            result.insert(transition.key.symbol)
            result.insert(transition.value.writeSymbol)
        }
    }
}
