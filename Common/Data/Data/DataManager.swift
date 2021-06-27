//
// Created by Shaban on 23/06/2021.
//

import Foundation

public protocol DataManagerContract {
    var contactsRepo: ContactsRepoContract { get }
}

public struct DataManager: DataManagerContract {
    public var contactsRepo: ContactsRepoContract = ContactsRepo.build()

    public static func create() -> DataManagerContract {
        DataManager()
    }
}
