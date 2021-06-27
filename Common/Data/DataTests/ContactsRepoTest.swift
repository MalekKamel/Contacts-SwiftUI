//
//  DataTests.swift
//  DataTests
//
//  Created by Shaban kamel on 30/3/21.
//

import XCTest
@testable import Data
import Combine
import Moya
import Presentation

class ContactsRepoTest: XCTestCase {
    var repo: ContactsRepo!
    private var localDataSrc: FakeContactsLocalDataSrc!

    override func setUp() {
        super.setUp()
        localDataSrc = FakeContactsLocalDataSrc()
        repo = ContactsRepo(
                localDataSrc: localDataSrc,
                storeDataSrc: FakeContactsStoreDataSrc(),
                synchronizer: FakeContactSynchronizer())
    }

    func testLoadContacts_shouldUpdateContacts() throws {
        let items: [ContactItem] = try awaitPublisher(repo.contacts())
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items, [ContactItem(id: "id", name: "name", phone: "phone"),
                                     ContactItem(id: "id2", name: "name", phone: "phone")])
    }

    func testSync_shouldUpdateContact() throws {
        let result = try awaitPublisher(repo.sync())
        XCTAssertTrue(result)
        XCTAssertTrue(localDataSrc.isSaved)
        XCTAssertTrue(localDataSrc.isUpdated)
        XCTAssertTrue(localDataSrc.isDeleted)
    }
}

class FakeContactsLocalDataSrc: ContactsLocalDataSrcContract {
    var isSaved = false
    var isUpdated = false
    var isDeleted = false

    public func all() -> AnyPublisher<[ContactItem], Error> {
        let items = [ContactItem(id: "id", name: "name", phone: "phone"),
                     ContactItem(id: "id2", name: "name", phone: "phone")]
        return Just(items)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }

    public func save(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        isSaved = true
        return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }

    public func update(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        isUpdated = true
        return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }

    public func delete(items: [ContactItem]) -> AnyPublisher<Void, Error> {
        isDeleted = true
        return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }
}

class FakeContactsStoreDataSrc: ContactsStoreDataSrcContract {
    public func all() -> AnyPublisher<[ContactItem], Error> {
        let items = [ContactItem(id: "id", name: "name", phone: "phone"),
                     ContactItem(id: "id2", name: "name", phone: "phone")]
        return Just(items)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }
}

class FakeContactSynchronizer: ContactSynchronizerContract {
    public func sync() -> AnyPublisher<ContactSyncResult, Error> {
        let result = ContactSyncResult(
                new: [ContactItem(id: "id", name: "name", phone: "phone")],
                modified: [ContactItem(id: "id", name: "name", phone: "phone")],
                deleted: [ContactItem(id: "id", name: "name", phone: "phone")]
        )
      return Just(result)
              .setFailureType(to: Error.self)
              .eraseToAnyPublisher()
    }
}