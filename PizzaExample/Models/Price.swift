import ObjectMapper

private extension String {

    static let sizeKey = "size"
    static let priceKey = "price"

}

struct Price: ImmutableMappable {

    let size: Int
    let price: NSDecimalNumber

    init(map: Map) throws {
        size = try map.value(.sizeKey)
        price = try map.value(.priceKey, using: NSDecimalNumberTransform())
    }

}
