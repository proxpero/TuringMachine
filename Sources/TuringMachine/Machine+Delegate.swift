extension Machine {
    public struct Delegate {
        public var didChangeState: (State) -> Void = { _ in }
        public var didChangeTapeIndex: (Int) -> Void = { _ in }
        public var didWriteSymbol: (Symbol) -> Void = { _ in }
        public var didHalt: (Move.Halt) -> Void = { _ in }

        public init(
            didChangeState: @escaping (State) -> Void = { _ in },
            didChangeTapeIndex: @escaping (Int) -> Void = { _ in },
            didWriteSymbol: @escaping (Symbol) -> Void = { _ in },
            didHalt: @escaping (Move.Halt) -> Void = { _ in }
        ) {
            self.didChangeState = didChangeState
            self.didChangeTapeIndex = didChangeTapeIndex
            self.didWriteSymbol = didWriteSymbol
            self.didHalt = didHalt
        }
    }
}
