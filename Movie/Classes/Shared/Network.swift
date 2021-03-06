import Alamofire
import RxAlamofire
import RxSwift

final class Network<T: Codable> {

    private let encoding: URLEncoding
    private let scheduler: ConcurrentDispatchQueueScheduler

    required init() {
        let dispatchQoS = DispatchQoS.QoSClass.background
        let qos = DispatchQoS(qosClass: dispatchQoS, relativePriority: 1)

        self.encoding = URLEncoding()
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: qos)
    }

    func get(_ path: URL, _ params: [String: Any]) -> Single<T> {
        RxAlamofire.data(.get, path, parameters: params, encoding: encoding).asSingle().observeOn(scheduler).map(T.self)
    }
}
