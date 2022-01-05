//let zero: State = .init(id: "0", move: "L")
//let one: State = .init(id: "1", move: "L")
//let two: State = .init(id: "2", move: "R")
//let three: State = .init(id: "3", move: "L")
//let four: State = .init(id: "4", move: "R")
//let five: State = .init(id: "5", move: "A")
//
//let _0: Symbol = "0"
//let _1: Symbol = "1"
//let plus: Symbol = "+"
//let blank: Symbol = "_"
//
//let binaryAdder: Machine = {
//    func transition(state: State, symbol: Symbol) -> (State, Symbol) {
//        var nextState = state
//        var write = symbol
//
//        switch (state, symbol) {
//        case (two, blank):
//            nextState = zero
//            write = blank
//        case (zero, _0):
//            write = _1
//        case (zero, _1):
//            nextState = one
//            write = _0
//        case (zero, plus):
//            nextState = four
//            write = blank
//        case (one, plus):
//            nextState = three
//            write = plus
//        case (three, _0):
//            nextState = two
//            write = _1
//        case (three, _1):
//            nextState = three
//            write = _0
//        case (three, blank):
//            nextState = two
//            write = _1
//        case (four, _1):
//            nextState = four
//            write = blank
//        case (four, blank):
//            nextState = five
//            write = blank
//        default:
//            break
//        }
//
//        return (nextState, write)
//    }
//
//    fatalError()
////    var machine: Machine = .init(
////        start: two,
////        blank: blank,
////        transitions: transition
////    )
////
////    let tape: [Symbol] = [_1, _0, _1, _0, plus, _1, _1, _1, _1]
////    machine.loadTape(tape, startIndex: 0)
////
////    return machine
//}()
