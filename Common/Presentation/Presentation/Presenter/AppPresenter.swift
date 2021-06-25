//
// Created by Apple on 04/04/2021.
//

import SwiftUI
import Combine
import Data

public protocol AppPresenter: ObservableObject {
    var screenState: ScreenState { get set }
    var cancellables: Set<AnyCancellable> { get set }
    func request<T>(_ api: AnyPublisher<T, Swift.Error>,
                    updateScreenState: Bool,
                    onError: ((Swift.Error) -> Void)?,
                    completion: @escaping (T) -> Void)
}

public extension AppPresenter {

    func request<T>(_ api: AnyPublisher<T, Swift.Error>,
                    updateScreenState: Bool = false,
                    onError: ((Swift.Error) -> Void)? = nil,
                    completion: @escaping (T) -> Void) {
        api.catch { [weak self]  error -> Empty<T, Never> in
                    onError?(error)
                    if updateScreenState {
                        self?.screenState = .failed(error)
                    }
                    return Empty<T, Never>()
                }
                .sink(receiveValue: { [weak self] value in
                    completion(value)
                    if updateScreenState {
                        self?.screenState = .loaded
                    }
                })
                .store(in: &cancellables)
    }

}
