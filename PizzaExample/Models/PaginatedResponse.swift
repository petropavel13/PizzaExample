import ObjectMapper

private extension String {

    static let itemsKey = "items"
    static let pageKey = "page"
    static let totalCountKey = "totalCount"

}

struct PaginatedResponse<T: ImmutableMappable>: ImmutableMappable {

    let items: [T]
    let page: Int
    let totalCount: Int

    init(map: Map) throws {
        items = try map.value(.itemsKey)
        page = try map.value(.pageKey)
        totalCount = try map.value(.totalCountKey)
    }

}

import LeadKit

extension PaginatedResponse: TotalCountCursorListingResult {

    var results: [T] {
        return items
    }

}
