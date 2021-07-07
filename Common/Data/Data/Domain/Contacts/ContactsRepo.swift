//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import ModelsMapper
import Combine
import Moya

public protocol ContactsRepoContract {
    func contacts() -> AnyPublisher<[ContactItem], AppError>
    func sync() -> AnyPublisher<Bool, AppError>
}

public struct ContactsRepo: ContactsRepoContract {
    private let localDataSrc: ContactsLocalDataSrcContract
    private let storeDataSrc: ContactsStoreDataSrcContract
    private let synchronizer: ContactSynchronizerContract

    public init(localDataSrc: ContactsLocalDataSrcContract,
                storeDataSrc: ContactsStoreDataSrcContract,
                synchronizer: ContactSynchronizerContract) {
        self.localDataSrc = localDataSrc
        self.storeDataSrc = storeDataSrc
        self.synchronizer = synchronizer
    }

    public func contacts() -> AnyPublisher<[ContactItem], AppError> {
        localDataSrc.all()
                .mapError { error in
                    error.toAppError
                }
                .flatMap { items -> AnyPublisher<[ContactItem], AppError> in
                    if !items.isEmpty {
                        return Just(items)
                                .setFailureType(to: AppError.self)
                                .eraseToAnyPublisher()
                    }
                    return retrieveContactsAndSaveLocally()
                }
                .eraseToAnyPublisher()
    }

    private func retrieveContactsAndSaveLocally() -> AnyPublisher<[ContactItem], AppError> {
        storeDataSrc.all()
                .flatMap { items in
                    save(items: items)
                            .map { _ in
                                items
                            }
                }
                .mapError { error in
                    error.toAppError
                }
                .eraseToAnyPublisher()
    }

    public func sync() -> AnyPublisher<Bool, AppError> {
        synchronizer.sync()
                .flatMap { result in
                    Publishers.Zip3(
                                    save(items: result.new),
                                    update(items: result.modified),
                                    delete(items: result.deleted))
                            .map { _ in
                                result.isModified()
                            }
                            .eraseToAnyPublisher()
                }
                .mapError { error in
                    error.toAppError
                }
                .eraseToAnyPublisher()
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