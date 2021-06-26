//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import ModelsMapper
import Combine
import Moya

public protocol ContactsRepoContract {
    func contacts() -> AnyPublisher<[ContactItem], MoyaError>
    func sync() -> Bool
}

public struct ContactsRepo: ContactsRepoContract {
    let localDataSrc: ContactsLocalDataSrcContract
    let storeDataSrc: ContactsStoreDataSrcContract
    let synchronizer: ContactSynchronizerContract

    public init(localDataSrc: ContactsLocalDataSrcContract,
                storeDataSrc: ContactsStoreDataSrcContract,
                synchronizer: ContactSynchronizerContract) {
        self.localDataSrc = localDataSrc
        self.storeDataSrc = storeDataSrc
        self.synchronizer = synchronizer
    }

    public func contacts() -> AnyPublisher<[ContactItem], MoyaError> {
        localDataSrc.all()
                .mapError { error in
                    MoyaError.underlying(error, nil)
                }
                .flatMap { items -> AnyPublisher<[ContactItem], MoyaError> in
                    if !items.isEmpty {
                        return Just(items)
                                .setFailureType(to: MoyaError.self)
                                .eraseToAnyPublisher()
                    }
                    return retrieveContactsAndSaveLocally()
                }
                .eraseToAnyPublisher()
    }

    private func retrieveContactsAndSaveLocally() -> AnyPublisher<[ContactItem], MoyaError> {
        storeDataSrc.all()
                .flatMap { items in
                    save(items: items)
                            .map { _ in
                                items
                            }
                }
                .mapError { error in
                    MoyaError.underlying(error, nil)
                }
                .eraseToAnyPublisher()
    }

    public func sync() -> Bool {
        true
    }

    private func save(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        localDataSrc.save(items: items)
    }

    private func update(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        localDataSrc.update(items: items)
    }

    private func delete(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        localDataSrc.delete(items: items)
    }
}

extension ContactsRepo {

    public static func build() -> ContactsRepo {
        ContactsRepo(
                localDataSrc: ContactsLocalDataSrc.build(),
                storeDataSrc: ContactsStoreDataSrc(retriever: ContactsRetriever()),
                synchronizer: ContactSynchronizer.build())
    }

}