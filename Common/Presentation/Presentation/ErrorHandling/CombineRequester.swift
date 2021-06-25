//
// Created by Shaban on 23/06/2021.
//

import Combine
import Moya

public typealias Request<T> = () -> AnyPublisher<T, MoyaError>

public struct CombineRequester {
    /// Set NSError handlers
    public static var nsErrorHandlers: Array<NSErrorHandler> = []

    /// Set Error handlers
    public static var errorHandlers: Array<ErrorHandler> = []

    public init() {
    }

    public func request<T>(
            _ publisher: AnyPublisher<T, MoyaError>,
            options: RequestOptions = RequestOptions.defaultOptions(),
            presentable: Presentable? = nil
    ) -> AnyPublisher<T, Never> {
        if options.showLoading {
            presentable?.showLoading()
        }
        return publisher
                .catch { error -> Empty<T, Never> in
                    options.doOnError?(error)
                    if options.inlineHandling?(error) == true {
                        return Empty<T, Never>()
                    }
                    ErrorProcessor.shared.process(error: error, presentable: presentable)
                    return Empty<T, Never>()
                }
                .handleEvents(receiveCompletion: { _ in
                    if options.hideLoading {
                        presentable?.hideLoading()
                    }
                })
                .eraseToAnyPublisher()
    }
}