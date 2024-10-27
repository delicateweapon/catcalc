let stream = "3 * (x + sin y)"
let tokenizer = Tokenizer()
let ast = AST()

do {
    try tokenizer.tokenize(stream: stream)
    try ast.construct(tokens: tokenizer.tokens)
    tokenizer.prettyPrint()
    ast.prettyPrint()
} catch TokenizerError.invalidChar(let message, let index) {
    print("Tokenization falied: \(message)")
    streamErrorPrint(stream: stream, index: index)
    print("Exiting catcalc")
} catch AstError.invalidParenthesis(let message, let index) {
    print("AST construction failed: \(message)")
    streamErrorPrint(stream: stream, index: index)
    print("Exiting catcalc")
}
