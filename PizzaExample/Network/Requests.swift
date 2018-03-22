import RxSwift
import LeadKit

extension PizzaNetworkService {

    func pizzaListing() -> Single<PaginatedResponse<Pizza>> {
        let parameters = ApiRequestParameters(relativeUrl: "pizza/listing")

        return request(with: parameters)
    }

}
