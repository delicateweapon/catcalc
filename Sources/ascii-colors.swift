enum AsciiColors: String {
    case RESET = "\u{001B}[0m"

    case FG_BLACK = "\u{001B}[30m"
    case FG_RED = "\u{001B}[31m"
    case FG_GREEN = "\u{001B}[32m"
    case FG_YELLOW = "\u{001B}[33m"
    case FG_BLUE = "\u{001B}[34m"
    case FG_MAGENTA = "\u{001B}[35m"
    case FG_CYAN = "\u{001B}[36m"
    case FG_WHITE = "\u{001B}[37m"

    case BG_BLACK = "\u{001B}[40m"
    case BG_RED = "\u{001B}[41m"
    case BG_GREEN = "\u{001B}[42m"
    case BG_YELLOW = "\u{001B}[43m"
    case BG_BLUE = "\u{001B}[44m"
    case BG_MAGENTA = "\u{001B}[45m"
    case BG_CYAN = "\u{001B}[46m"
    case BG_WHITE = "\u{001B}[47m"
}

func coloredPrint(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    bg: AsciiColors,
    fg: AsciiColors
) {
    let str = items.map { "\($0)" }.joined(separator: separator)
    print(
        "\(bg.rawValue)\(fg.rawValue)\(str)\(AsciiColors.RESET.rawValue)",
        separator: separator,
        terminator: terminator)
}
