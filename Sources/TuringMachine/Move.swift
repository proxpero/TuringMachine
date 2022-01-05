public enum Move: Hashable {
    public enum Halt: Hashable {
        case accept
        case reject
    }

    case left
    case right
    case halt(Halt)

    public static let accept: Self = .halt(.accept)
    public static let reject: Self = .halt(.reject)
}

extension Move: ExpressibleByStringLiteral, RawRepresentable {
    public var rawValue: String {
        get {
            switch self {
            case .left: return "L"
            case .right: return "R"
            case .halt(let result):
                switch result {
                case .accept: return "Y"
                case .reject: return "N"
                }
            }
        }
        set {
            switch newValue {
            case "L":
                self = .left
            case "R":
                self = .right
            case "Y":
                self = .accept
            case "N":
                self = .reject
            default:
                fatalError()
            }
        }
    }

    public init?(rawValue value: String) {
        switch value {
        case "L":
            self = .left
        case "R":
            self = .right
        case "Y":
            self = .accept
        case "N":
            self = .reject
        default:
            return nil
        }
    }

    public init(stringLiteral value: StringLiteralType) {
        switch value.uppercased() {
        case "L": self = .left
        case "R": self = .right
        case "Y": self = .accept
        case "N": self = .reject
        default:
            fatalError()
        }
    }
}
