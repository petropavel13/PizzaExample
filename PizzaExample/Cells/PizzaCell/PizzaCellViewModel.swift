struct PizzaCellViewModel {

    let pizza: Pizza

}

extension PizzaCellViewModel {

    var ingridients: String {
        return pizza.ingridients
            .map { $0.capitalized }
            .joined(separator: ", ")
    }

}
