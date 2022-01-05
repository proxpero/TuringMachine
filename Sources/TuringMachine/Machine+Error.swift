extension Machine {
    enum Error: Swift.Error {
        case invalidFileFormat(String)
        case inputAlphabetMustBeSubsetOfTapeAlphabet
        case startNotContainedInStates
        case unrecognizedState(State)
        case unrecognizedSymbol(Symbol)
    }
}
