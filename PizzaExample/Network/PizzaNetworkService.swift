import LeadKit
import Alamofire
import RxSwift
import ObjectMapper

class PizzaNetworkService: NetworkService {

    static let shared = PizzaNetworkService()

    private convenience init() {
        self.init(sessionManager: SessionManager(configuration: .default))
    }

    static let baseUrl = "https://665256ba-8801-40db-a38c-1d30d9ac801c.mock.pstmn.io/"

    func request<T: ImmutableMappable>(with parameters: ApiRequestParameters) -> Single<T> {
        let apiResponseRequest = rxRequest(with: parameters) as Observable<(response: HTTPURLResponse, model: T)>

        return apiResponseRequest
            .map { $0.model }
            .do(onError: {
                debugPrint($0)
            })
            .asSingle()
    }

}


extension ApiRequestParameters {

    init(relativeUrl: String,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil) {

        let fullUrl = PizzaNetworkService.baseUrl + relativeUrl

        self.init(url: fullUrl,
                  method: method,
                  parameters: parameters,
                  headers: ["x-api-key": "064911a53f8e47b0a5c8eff084143bfb"])
    }

}
