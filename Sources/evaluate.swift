extension AST {
    private func eval() {

    }

    func evaluate() throws -> Float64 {

        let result: Float64 = 0.0

        for (key, value) in self.variables {
            if value.value == nil {
                throw AstError.variablesNotSet(
                    message: "Variable \(key) is not set", index: value.index)
            }
        }

        return result
    }
}
