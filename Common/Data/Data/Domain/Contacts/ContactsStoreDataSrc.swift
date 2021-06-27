//
// Created by Shaban on 25/06/2021.
//

import Combine

public protocol ContactsStoreDataSrcContract {
    func all() -> AnyPublisher<[ContactItem], Error>
}

public struct ContactsStoreDataSrc: ContactsStoreDataSrcContract {
    let retriever: ContactsRetriever

    public init(retriever: ContactsRetriever) {
        self.retriever = retriever
    }

    public func all() -> AnyPublisher<[ContactItem], Error> {
        retriever.retrieve()
    }
}

extension ContactsStoreDataSrc {

    public static func build() -> ContactsStoreDataSrcContract {
        ContactsStoreDataSrc(retriever: ContactsRetriever())
    }
}