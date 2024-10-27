enum AstError: Error {
    case invalidParenthesis(message: String, index: String.Index)
    case variablesNotSet(message: String, index: String.Index)
}

enum NodeValue {
    case op(Operator)
    case n(Float64)
    case v(String, Float64?)

    func getPrecedence() -> UInt8? {
    switch self {
    case .op(let o):
        return o.getPrecedence()
    case .n, .v:
        return nil
    }
    }
}

class Node {
    var value: NodeValue?
    var subNodes: [Node]

    init(value: NodeValue?) {
        self.value = value
        self.subNodes = []
        self.subNodes.reserveCapacity(2)
    }
}

class AST {
    var root: Node
    var variables: [String: (value: Float64?, index: String.Index)]
    private var head: Node
    private var reqArgs: UInt8?

    init() {
        self.root = Node(value: nil)
        self.variables = [:]
        self.head = root
        self.reqArgs = nil
    }

    func construct(tokens: [Token]) throws {
        for token in tokens {
            self.parse(token: token, node: self.root)
        }
    }

    private func parse(token: Token, node: Node) {
        switch token {
        case .IDENT(let index, let ident):
            variables[ident] = (nil, index)
            head.subNodes.append(Node(value: .v(ident, nil)))

        case .NUMBER(_, let n):
            head.subNodes.append(Node(value: .n(Float64(n))))

        case .OPERATOR(_, let op):
            if head.value == nil {
                head.value = .op(op)
                reqArgs = op.getArgsCount()
                return
            }

        case .LPAREN(_):
            print("nothing")

        case .RPAREN(_):
            print("nothing")
        }
    }

    func prettyPrint() {
        print("prettyPrint() for AST not implemented yet")
    }
}
