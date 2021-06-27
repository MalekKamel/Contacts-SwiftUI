//
// Created by Shaban on 27/06/2021.
//

import Combine

extension Published.Publisher {
    func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        self.dropFirst()
                .collect(count)
                .first()
                .eraseToAnyPublisher()
    }
}