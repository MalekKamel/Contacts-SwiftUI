//
//  ContactsTests.swift
//
//  Created by Shaban kamel on 30/3/21.
//

import XCTest
@testable import App
import Combine
import Presentation

class HomeVMTests: XCTestCase {

    var vm: HomeVM = HomeVM(dataManager: FakeDataManager(), requester: CombineRequester())

    override func setUp() {
        super.setUp()
    }

    func testLoadContacts_shouldUpdateContacts() throws {
        vm.loadContacts()
        let publisher = vm.$contacts.collectNext(2)

        let items = try awaitPublisher(publisher)
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items.first, [ContactItem(id: "id", name: "name", phone: "phone"),
                                     ContactItem(id: "id2", name: "name", phone: "phone")])
    }

    func testSync_shouldUpdateContact() throws {
        vm.sync()
        let publisher = vm.$contacts.collectNext(2)

        let items = try awaitPublisher(publisher)
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items.first, [ContactItem(id: "id", name: "name", phone: "phone"),
                                     ContactItem(id: "id2", name: "name", phone: "phone")])
    }

}


class FakeContactsRepo: ContactsRepoContract {
    func contacts() -> AnyPublisher<[ContactItem], AppError> {
        let items = [ContactItem(id: "id", name: "name", phone: "phone"),
                     ContactItem(id: "id2", name: "name", phone: "phone")]
        return Just(items)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
    }

    func sync() -> AnyPublisher<Bool, AppError> {
        Just(true)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
    }
}

class FakeDataManager: DataManagerContract {
    private(set) var contactsRepo: ContactsRepoContract = FakeContactsRepo()

}