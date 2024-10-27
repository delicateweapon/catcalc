enum Operator {
    case ADD
    case SUBTRACT
    case MULTIPLY
    case DIVIDE
    case POW
    case SIN
    case COS
    case TAN
    case FACTORIAL
}

enum OperatorError: Error {
    case invalidStr
}

extension Operator {

    func getArgsCount() -> UInt8 {
        switch self {
        case .ADD, .SUBTRACT, .MULTIPLY, .DIVIDE, .POW:
            return 2
        case .SIN, .COS, .TAN, .FACTORIAL:
            return 1
        }
    }

    func getPrecedence() -> UInt8 {
        switch self {
        case .ADD, .SUBTRACT:
            return 0
        case .MULTIPLY:
            return 1
        case .DIVIDE:
            return 2
        case .POW:
            return 3
        case .SIN, .COS, .TAN:
            return 4
        case .FACTORIAL:
            return 5
        }
    }

    static func fromSymbol(str: String) throws -> Operator {
        switch str.lowercased() {
        case "add", "addition", "+":
            return .ADD
        case "sub", "subtract", "-":
            return .SUBTRACT
        case "mul", "multiply", "*":
            return .MULTIPLY
        case "div", "divide", "/":
            return .DIVIDE
        case "pow", "power", "^":
            return .POW
        case "sin", "sine":
            return .SIN
        case "cos", "cosine":
            return .COS
        case "tan", "tangent":
            return .TAN
        case "fact", "factorial", "!":
            return .FACTORIAL
        default:
            throw OperatorError.invalidStr
        }
    }
}
