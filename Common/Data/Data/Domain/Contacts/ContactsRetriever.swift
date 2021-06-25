//
// Created by Shaban on 25/06/2021.
//

import Contacts
import Combine

public struct ContactsRetriever {

    public init() {

    }

    public func grantPermission(_ completion: @escaping (Bool) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { (granted, error) in
            completion(granted)
        }
    }

    public func retrieve() -> AnyPublisher<[ContactItem], Error> {
        Future { promise in
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do {
                var contacts = [ContactItem]()
                try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                    let item = ContactItem(
                            id: contact.identifier,
                            name: "\(contact.givenName) \(contact.familyName)",
                            phone: contact.phoneNumbers.first?.value.stringValue ?? "")
                    contacts.append(item)
                })
                promise(.success(contacts))
            } catch let error {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

}