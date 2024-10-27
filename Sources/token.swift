enum Token {
    case LPAREN(index: String.Index)
    case RPAREN(index: String.Index)
    case NUMBER(index: String.Index, n: UInt32)
    case IDENT(index: String.Index, s: String)
    case OPERATOR(index: String.Index, op: Operator)
}

enum TokenizerError: Error {
    case invalidChar(message: String, index: String.Index)
}

class Tokenizer: PrettyPrint {
    var tokens: [Token]

    init() {
        tokens = []
        tokens.reserveCapacity(32)
    }

    func tokenize(stream: String) throws {
        var currentIndex = stream.startIndex
        let endIndex = stream.endIndex

        while currentIndex < endIndex {
            let c = stream[currentIndex]

            switch c {

            case " ":
                currentIndex = stream.index(after: currentIndex)
                continue

            case "(":
                self.tokens.append(.LPAREN(index: currentIndex))

            case ")":
                self.tokens.append(.RPAREN(index: currentIndex))

            case let char where char.isNumber:
                let start = currentIndex
                while currentIndex < endIndex, stream[currentIndex].isNumber {
                    currentIndex = stream.index(after: currentIndex)
                }
                if let number = UInt32(stream[start..<currentIndex]) {
                    self.tokens.append(.NUMBER(index: start, n: number))
                }
                continue

            case let char where char.isLetter:
                let start = currentIndex
                while currentIndex < endIndex, stream[currentIndex].isLetter {
                    currentIndex = stream.index(after: currentIndex)
                }
                let str = String(stream[start..<currentIndex])
                do {
                    let op: Operator = try Operator.fromSymbol(str: str)
                    self.tokens.append(.OPERATOR(index: start, op: op))
                } catch OperatorError.invalidStr {
                    self.tokens.append(.IDENT(index: start, s: str))
                }
                continue

            default:
                do {
                    let op: Operator = try Operator.fromSymbol(str: String(c))
                    self.tokens.append(.OPERATOR(index: currentIndex, op: op))
                } catch OperatorError.invalidStr {
                    throw TokenizerError.invalidChar(message: "Invalid Char", index: currentIndex)
                }
            }
            currentIndex = stream.index(after: currentIndex)
        }
    }

    func prettyPrint() {
        for token in self.tokens {
            switch token {
            case .LPAREN:
                coloredPrint("LPAREN", bg: .BG_BLACK, fg: .FG_MAGENTA)
            case .RPAREN:
                coloredPrint("RPAREN", bg: .BG_BLACK, fg: .FG_MAGENTA)
            case .NUMBER(_, let n):
                print("NUMBER ", terminator: "")
                coloredPrint("\(n)", bg: .BG_BLACK, fg: .FG_BLUE)
            case .IDENT(_, let s):
                print("IDENT ", terminator: "")
                coloredPrint("\(s)", bg: .BG_BLACK, fg: .FG_RED)
            case .OPERATOR(_, let op):
                print("OPERATOR ", terminator: "")
                coloredPrint("\(op)", bg: .BG_BLACK, fg: .FG_YELLOW)
            }
        }
    }
}
