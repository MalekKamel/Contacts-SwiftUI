//
// Created by Shaban on 25/06/2021.
//

import Combine
import Core

public protocol ContactSynchronizerContract {
     func sync() -> AnyPublisher<ContactSyncResult, Error>
}

public struct ContactSynchronizer: ContactSynchronizerContract {
    let localDataSrc: ContactsLocalDataSrcContract
    let storeDataSrc: ContactsStoreDataSrcContract
    private var bag = CancelableBag()

    public init(localDataSrc: ContactsLocalDataSrcContract, storeDataSrc: ContactsStoreDataSrcContract) {
        self.localDataSrc = localDataSrc
        self.storeDataSrc = storeDataSrc
    }

    public  func sync() -> AnyPublisher<ContactSyncResult, Error> {
        Publishers.Zip(localDataSrc.all(), storeDataSrc.all())
                .map { localItems, storeItems in
                    sync(localItems: localItems, storeItems: storeItems)
                }.eraseToAnyPublisher()
    }

   private func sync(localItems: [ContactItem], storeItems: [ContactItem]) -> ContactSyncResult {
        var localItemsDict = [String: ContactItem]()
        var storeItemsDict = [String: ContactItem]()

        localItems.forEach { item in
            localItemsDict[item.id] = item
        }
        storeItems.forEach { item in
            storeItemsDict[item.id] = item
        }

        var newItems = [ContactItem]()
        var modifiedItems = [ContactItem]()
        var deletedItems = [ContactItem]()

        for storeItem in storeItems {
            let localItem = localItemsDict[storeItem.id]

            // The item is not saved locally, it's a new one
            if localItem == nil {
                newItems.append(storeItem)
                continue
            }

            let soreHash = storeItem.hashValue
            let localHash = localItem.hashValue
            // The item is not modified, ignore it.
            if storeItem == localItem {
                continue
            }

            modifiedItems.append(storeItem)
        }

        // Find deleted items
        for localItem in localItems {
            let storeItem = storeItemsDict[localItem.id]
            if storeItem != nil {
                continue
            }
            deletedItems.append(localItem)
        }

        return ContactSyncResult(new: newItems, modified: modifiedItems, deleted: deletedItems)
    }

}

extension ContactSynchronizer {

    public static func build() -> ContactSynchronizerContract {
        ContactSynchronizer(
                localDataSrc: ContactsLocalDataSrc.build(),
                storeDataSrc: ContactsStoreDataSrc(retriever: ContactsRetriever()))
    }
}