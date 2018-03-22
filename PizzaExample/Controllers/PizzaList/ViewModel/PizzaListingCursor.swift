import LeadKit
import RxSwift

final class PizzaListingCursorConfiguration: TotalCountCursorConfiguration {

    typealias ResultType = PaginatedResponse<Pizza>

    private var page: Int = 1

    init() {
        // nothing to init
    }

    init(resetFrom other: PizzaListingCursorConfiguration) {
        // nothing to reset
    }

    func resultSingle() -> Single<ResultType> {
        return PizzaNetworkService.shared.pizzaListing()
    }

}

typealias PizzaListingCursor = TotalCountCursor<PizzaListingCursorConfiguration>

extension TotalCountCursor where CursorConfiguration == PizzaListingCursorConfiguration {

    convenience init() {
        self.init(configuration: PizzaListingCursorConfiguration())
    }

}
