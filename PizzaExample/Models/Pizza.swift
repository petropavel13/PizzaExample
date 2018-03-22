import ObjectMapper

private extension String {

    static let nameKey = "name"
    static let ingridientsKey = "ingridients"
    static let pricesKey = "prices"
    static let imageUrlKey = "imageUrl"

}

struct Pizza: ImmutableMappable {

    let name: String
    let ingridients: [String]
    let prices: [Price]
    let imageUrl: URL

    init(map: Map) throws {
        name = try map.value(.nameKey)
        ingridients = try map.value(.ingridientsKey)
        prices = try map.value(.pricesKey)
        imageUrl = try map.value(.imageUrlKey, using: URLTransform())
    }

}
