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
