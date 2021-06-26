//
// Created by Shaban on 25/06/2021.
//

import Foundation

public struct ContactSyncResult {
        public let new: [ContactItem]
        public let modified: [ContactItem]
        public let deleted: [ContactItem]
}
