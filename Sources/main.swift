let stream = "3 + 4"
let tokenizer = Tokenizer()
let ast = AST()

do {
    try tokenizer.tokenize(stream: stream)
    tokenizer.prettyPrint()
    try ast.construct(tokens: tokenizer.tokens)
    let result = try ast.evaluate()
    coloredPrint("RESULT: ", terminator: "", bg: .BG_BLACK, fg: .FG_MAGENTA)
    coloredPrint("\(result)", bg: .BG_BLACK, fg: .FG_WHITE)
} catch TokenizerError.invalidChar(let message, let index) {
    print("Tokenization falied: \(message)")
    streamErrorPrint(stream: stream, index: index)
    print("Exiting catcalc")
} catch AstError.invalidParenthesis(let message, let index) {
    print("AST construction failed: \(message)")
    streamErrorPrint(stream: stream, index: index)
    print("Exiting catcalc")
} catch AstError.variablesNotSet(let message, let index) {
    print("AST evaluation failed: \(message)")
    streamErrorPrint(stream: stream, index: index)
    print("Exiting catcalc")
}
