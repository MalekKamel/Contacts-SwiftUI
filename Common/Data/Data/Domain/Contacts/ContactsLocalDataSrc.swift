//
// Created by Shaban on 25/06/2021.
//

import Combine
import ModelsMapper

public protocol ContactsLocalDataSrcContract {
    func all() -> AnyPublisher<[ContactItem], Error>
    func save(items: [ContactItem]) -> AnyPublisher<Void, Error>
    func update(items: [ContactItem]) -> AnyPublisher<Void, Error>
    func delete(items: [ContactItem]) -> AnyPublisher<Void, Error>
}

public struct ContactsLocalDataSrc: ContactsLocalDataSrcContract {
    let dao: ContactsDao

    public init(dao: ContactsDao) {
        self.dao = dao
    }

    public func all() -> AnyPublisher<[ContactItem], Error> {
        dao.all()
                .map { items in
                    ListMapper(ContactEntityMapper()).map(items)
                }
                .eraseToAnyPublisher()
    }

    public func save(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        let entities = ListMapper(ContactItemMapper()).map(items)
        return dao.add(entities)
    }

    public func update(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        let entities = ListMapper(ContactItemMapper()).map(items)
        return dao.add(entities)
    }

    public func delete(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        let entities = ListMapper(ContactItemMapper()).map(items)
        return dao.delete(entities)
    }
}

extension ContactsLocalDataSrc {

    public static func build() -> ContactsLocalDataSrcContract {
        ContactsLocalDataSrc(dao: ContactsDao.build())
    }

}