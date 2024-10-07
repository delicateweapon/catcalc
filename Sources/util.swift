protocol PrettyPrint {
    func prettyPrint()
}

func streamErrorPrint(stream: String, index: String.Index) {
    print(stream[..<index], terminator: "")
    coloredPrint(stream[index], terminator: "", bg: .BG_BLACK, fg: .FG_RED)
    print(stream[stream.index(after: index)...])
}
