enum Token {
    case LPAREN
    case RPAREN
    case NUMBER(UInt32)
    case IDENT(String)
    case OPERATOR(Operator)
}

enum TokenizerError: Error {
    case invalidChar
}

class Tokenizer: printable {
    var tokens: [Token]

    init() {
        tokens = []
        tokens.reserveCapacity(32)
    }

    func tokenize(stream: String) throws {
        let characters = Array(stream)
        var i = 0
        while i < characters.count {
            let c = characters[i]

            switch c {
            case " ":
                i += 1
                continue
            case "(":
                self.tokens.append(.LPAREN)
            case ")":
                self.tokens.append(.RPAREN)
            case let char where char.isNumber:
                let start = i
                while i < stream.count && characters[i].isNumber {
                    i += 1
                }
                if let number = UInt32(String(characters[start..<i])) {
                    self.tokens.append(.NUMBER(number))
                }
                continue
            case let char where char.isLetter:
                let start = i
                while i < stream.count && characters[i].isLetter {
                    i += 1
                }
                let str = String(characters[start..<i])
                do {
                    let op: Operator = try Operator.fromSymbol(str: str)
                    self.tokens.append(.OPERATOR(op))
                } catch OperatorError.invalidStr {
                    self.tokens.append(.IDENT(str))
                }
                continue
            default:
                do {
                    let op: Operator = try Operator.fromSymbol(str: String(c))
                    self.tokens.append(.OPERATOR(op))
                } catch OperatorError.invalidStr {
                    print("Nothing has been implented for \'\(c)\' yet")
                    throw TokenizerError.invalidChar
                }
            }

            i += 1
        }
    }

    func prettyPrint() {
        for token in self.tokens {
            switch token {
            case .LPAREN:
                coloredPrint("LPAREN", bg: .BG_BLACK, fg: .FG_MAGENTA)
            case .RPAREN:
                coloredPrint("RPAREN", bg: .BG_BLACK, fg: .FG_MAGENTA)
            case .NUMBER(let n):
                print("NUMBER ", terminator: "")
                coloredPrint("\(n)", bg: .BG_BLACK, fg: .FG_BLUE)
            case .IDENT(let s):
                print("IDENT ", terminator: "")
                coloredPrint("\(s)", bg: .BG_BLACK, fg: .FG_RED)
            case .OPERATOR(let op):
                print("OPERATOR ", terminator: "")
                coloredPrint("\(op)", bg: .BG_BLACK, fg: .FG_YELLOW)
            }
        }
    }
}
