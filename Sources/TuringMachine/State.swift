public struct State: Identifiable, Hashable {
    public let id: String
    public let move: Move

    public init(id: String, move: Move) {
        self.id = id
        self.move = move
    }
}
