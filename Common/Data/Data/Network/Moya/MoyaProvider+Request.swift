//
// Created by Shaban on 18/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Moya
import Combine

extension MoyaProvider {
    func request<R: Decodable>(target: Target) -> DecodePublisher<R> {
        let passSubject = PassthroughSubject<R, AppError>()
        request(target) {
            switch $0 {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(R.self, from: response.data)
                    passSubject.send(result)
                } catch {
                    passSubject.send(completion: .failure(error.toAppError))
                }
            case let .failure(error):
                passSubject.send(completion: .failure(error.toAppError))
            }
        }
        return passSubject.eraseToAnyPublisher()
    }
}