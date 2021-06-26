//
// Created by Shaban Kamel on 31/03/2021.
//

import Foundation
import ModelsMapper

public struct ContactItem: Identifiable, Hashable {
    public var id: String
    public var name: String
    public var phone: String

    public init(id: String, name: String, phone: String) {
        self.id = id
        self.name = name
        self.phone = phone
    }
}

class ContactResponseMapper: Mapper {
    typealias I = ContactsResponse
    typealias O = ContactItem

    func map(_ input: ContactsResponse) -> ContactItem {
        ContactItem(
                id: input.id,
                name: input.name,
                phone: input.phone)
    }
}

