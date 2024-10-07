enum AstError: Error {
    case invalidParenthesis(message: String, index: String.Index)
}

class AST: PrettyPrint {
    var variables: [String: Float64]
    var numberStack: [Float64]
    var operatorStack: [Operator]
    var stopIndices: [Int]

    init() {
        self.variables = [:]
        self.numberStack = []
        self.numberStack.reserveCapacity(16)
        self.operatorStack = []
        self.operatorStack.reserveCapacity(16)
        self.stopIndices = []
        self.stopIndices.reserveCapacity(16)
    }

    func construct(tokens: [Token]) throws {
        for token in tokens {
            switch token {
            case .IDENT(let ident, _):
                self.variables[ident] = 0.0
            case .OPERATOR(let op, _):
                self.operatorStack.append(op)
            case .LPAREN:
                self.stopIndices.append(self.operatorStack.count)
            case .RPAREN(let index):
                let stopIndex = self.stopIndices.popLast()
                if stopIndex == nil {
                    throw AstError.invalidParenthesis(
                        message: "Invalid Parenthesis", index: index)
                }
                var op = self.operatorStack.popLast()
                while true {
                    if op == nil {
                        throw AstError.invalidParenthesis(
                            message: "Invalid Parenthesis", index: index)
                    }
                    if self.operatorStack.count == stopIndex {
                        break
                    }
                    op = self.operatorStack.popLast()
                }
            default:
                continue
            }
        }
    }

    func prettyPrint() {
        coloredPrint("\(self.variables.count) variables found", bg: .BG_BLACK, fg: .FG_GREEN)
        for (key, value) in self.variables {
            coloredPrint("\(key)\t", terminator: "", bg: .BG_BLACK, fg: .FG_RED)
            coloredPrint(value, bg: .BG_BLACK, fg: .FG_CYAN)
        }
    }
}
