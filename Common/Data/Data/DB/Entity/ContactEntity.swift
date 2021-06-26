//
// Created by Apple on 01/08/2020.
// Copyright (c) 2020 sha. All rights reserved.
//

import RealmSwift
import ModelsMapper

@objcMembers
public class ContactEntity: Object, Identifiable {
    public static let key = "ContactEntity.key"

    public dynamic var id: String = ""
    public dynamic var name: String = ""
    public dynamic var phone: String = ""

    public override static func primaryKey() -> String? {
        "id"
    }

}

class ContactItemMapper: Mapper {
    typealias I = ContactItem
    typealias O = ContactEntity

    func map(_ input: ContactItem) -> ContactEntity {
        let out = ContactEntity()
        out.id = input.id
        out.name = input.name
        out.phone = input.phone
        return out
    }
}

class ContactEntityMapper: Mapper {
    typealias I = ContactEntity
    typealias O = ContactItem

    func map(_ input: ContactEntity) -> ContactItem {
        ContactItem(
                id: input.id,
                name: input.name,
                phone: input.phone)
    }
}