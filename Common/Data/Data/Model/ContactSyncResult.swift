//
// Created by Shaban on 25/06/2021.
//

import Foundation

public struct ContactSyncResult {
    public let new: [ContactItem]
    public let modified: [ContactItem]
    public let deleted: [ContactItem]

    public func isModified() -> Bool {
        !new.isEmpty || !modified.isEmpty || !deleted.isEmpty
    }
}
