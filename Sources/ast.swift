enum AstError: Error {
    case invalidParenthesis(message: String, index: String.Index)
}

enum NodeValue {
    case op(Operator)
    case v(String, Float64)
}

class Node {
    let value: NodeValue
    let subNodes: [Node]

    init(value: NodeValue) {
        self.value = value
        self.subNodes = []
    }
}

class AST: PrettyPrint {
    let root: Node

    func prettyPrint() {
        print("prettyPrint for AST not implemented yet")
    }
}
