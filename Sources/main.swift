let tokenizer = Tokenizer()
do {
    try tokenizer.tokenize(stream: "3 * (x + sin y)")
    tokenizer.prettyPrint()
} catch TokenizerError.invalidChar {
    print("Exiting catcalc")
}
