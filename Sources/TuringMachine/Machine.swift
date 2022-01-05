import Collections
import Foundation

public typealias Symbol = String

public struct Machine {
    public var title: String?
    public var description: String?

    public let startState: State
    public private(set) var currentState: State
    let blank: Symbol
    let transitions: Transitions

    public var delegate: Delegate?

    public var isHalted: Bool = false
    private(set) var tape: Deque<Symbol> = []
    private(set) var current: Int = 0 {
        didSet {
            delegate?.didChangeTapeIndex(current)
        }
    }

    private(set) var stepCount = 0

    public init(
        title: String? = nil,
        description: String? = nil,
        start: State,
        blank: Symbol,
        transitions: Transitions
    ) {
        self.title = title
        self.description = description
        self.startState = start
        self.currentState = start
        self.blank = blank
        self.transitions = transitions
    }
}

extension Machine {
    mutating func loadTape(_ tape: [Symbol], startIndex: Int) {
        self.tape = .init(tape)
        current = startIndex
    }

    mutating func loadTape(_ tape: String, startIndex: Int) throws {
        let symbols = tape.split(separator: " ").map(String.init)
        loadTape(symbols, startIndex: startIndex)
    }

    mutating func step() {
        stepCount += 1
        let (nextState, writeSymbol) = transitions[currentState, tape[current]] ?? (currentState, tape[current])

        currentState = nextState
        delegate?.didChangeState(nextState)

        if case .halt(let result) = currentState.move {
            isHalted = true
            delegate?.didHalt(result)
            return
        }

        tape[current] = writeSymbol
        delegate?.didWriteSymbol(writeSymbol)

        switch nextState.move {
        case .left:
            current = tape.index(before: current)
            if current < tape.startIndex {
                tape.prepend(blank)
                current = tape.startIndex
            }

        case .right:
            current = tape.index(after: current)
            if current == tape.endIndex {
                tape.append(blank)
            }

        default: break
        }
    }

    mutating func run() {
        while !isHalted {
            step()
        }
    }

    #warning("Implement reset: separate fundamental state from runtime state and preserve current tape. support undo?")
    mutating func reset() {}
}

extension Machine: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.startState == rhs.startState &&
            lhs.blank == rhs.blank &&
            lhs.transitions == rhs.transitions
    }
}
