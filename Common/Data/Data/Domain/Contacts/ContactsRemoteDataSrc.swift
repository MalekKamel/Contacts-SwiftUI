//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import Combine

class ContactsRemoteDataSrc {
    let api: ContactsApiProvider

    init(api: ContactsApiProvider) {
        self.api = api
    }

    func loadContacts() -> AnyPublisher<[ContactItem], AppError> {
        Future { promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }

}