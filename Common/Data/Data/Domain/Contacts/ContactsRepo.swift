//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import ModelsMapper
import Combine
import Moya

public class ContactsRepo {
    let dataSrc: ContactsDataSrc
    let contactsRetriever: ContactsRetriever

    public static func build() -> ContactsRepo {
        ContactsRepo(
                dataSrc: ContactsDataSrc(api: MoyaProvider<ContactsApi>.create()),
                contactsRetriever: ContactsRetriever())
    }

    init(dataSrc: ContactsDataSrc, contactsRetriever: ContactsRetriever) {
        self.dataSrc = dataSrc
        self.contactsRetriever = contactsRetriever
    }

    public func loadContacts() -> AnyPublisher<[ContactItem], MoyaError> {
        contactsRetriever.retrieve()
                .mapError { error in
                    MoyaError.underlying(error, nil)
                }
                .eraseToAnyPublisher()
    }

}