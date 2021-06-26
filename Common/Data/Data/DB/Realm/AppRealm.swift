import RealmSwift
import Realm
import Core
import Combine

public var realmQueue: DispatchQueue = {
    DispatchQueue.main
}()

public struct AppRealm {
    public static let shared = AppRealm()

    public init() {
    }

    func add<T: Object>(_ obj: T) -> AnyPublisher<Void, Error> {
        Future { promise in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread
                            let object = obj.detached()
                            realm.add(object, update: .all)
                            promise(.success(()))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    func add<T: Object>(_ objects: [T]) -> AnyPublisher<Void, Error> {
        Future { promise in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread

                            for obj in objects {
                                let object = obj.detached()
                                realm.add(object, update: .all)
                            }

                            promise(.success(()))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    func delete<T: Object>(_ objects: [T]) -> AnyPublisher<Void, Error> {
        Future { promise in
            realmQueue.async {
                autoreleasepool {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            for obj in objects {
                                realm.delete(obj)
                            }
                        }
                        promise(.success(()))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    func delete<T: Object>(_ obj: T) -> AnyPublisher<Void, Error> {
        Future { promise in
            realmQueue.async {
                autoreleasepool {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            realm.delete(obj)
                            promise(.success(()))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    func object<T: Object, KeyType>(forPrimaryKey key: KeyType) -> AnyPublisher<T?, Error> {
        Future { promise in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let obj = realm.object(ofType: T.self, forPrimaryKey: key)
                    guard let object: T = obj else {
                        promise(.success(nil))
                        return
                    }
                    // detach to keep the object unmanaged to use it
                    // in any thread
                    let detached = object.detached()
                    promise(.success(object))
                }
            }
        }.eraseToAnyPublisher()
    }

    func objects<T: Object>() -> AnyPublisher<[T], Error> {
        Future { promise in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let list = realm.objects(T.self)
                    // detach to keep the object unmanaged to use it
                    // in any thread
                    let detached = list.detached
                    promise(.success(detached))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
