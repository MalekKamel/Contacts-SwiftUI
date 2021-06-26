import Combine
import RealmSwift

public struct ContactsDao {
    let realm: AppRealm

    public init(realm: AppRealm) {
        self.realm = realm
    }

    public func all() -> AnyPublisher<[ContactEntity], Error> {
        AppRealm.shared.objects()
    }

    public func add(_ item: ContactEntity) -> AnyPublisher<Void, Error> {
        AppRealm.shared.add(item)
    }

    public func add(_ items: [ContactEntity]) -> AnyPublisher<Void, Error> {
        AppRealm.shared.add(items)
    }

    public func delete(_ items: [ContactEntity]) -> AnyPublisher<Void, Error> {
        AppRealm.shared.delete(items)
    }

    public func item(itemId: String) -> AnyPublisher<ContactEntity?, Error> {
        AppRealm.shared.object(forPrimaryKey: itemId)
    }

}

extension ContactsDao {

    public static func build() -> ContactsDao {
        ContactsDao(realm: AppRealm.shared)
    }
}