//
// Created by Shaban Kamel on 31/03/2021.
//

import Foundation

public struct ContactsResponse: Decodable {
    public var id: Int
    public var name: String
    public var phone: String
}
