//
// Created by Shaban on 26/06/2021.
//

import BackgroundTasks
import Core

public class ContactsBackgroundSynchronizer {
    public static let shared = ContactsBackgroundSynchronizer()
    private let identifier = "com.contacts.app.synchronizer"
    private let contactsRepo = ContactsRepo.build()
    private var bag = CancelableBag()

    public init() {
    }

    public func start() {
        ScheduledBackgroundTask(identifier: identifier, scheduleInterval: 15 * 60) { task in
            self.sync(task)
        }
                .start()
    }

    private func sync(_ task: BGTask) {
        contactsRepo.sync().sink(
                        receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                task.setTaskCompleted(success: true)
                            case .failure:
                                task.setTaskCompleted(success: false)
                            }
                        },
                        receiveValue: { _ in

                        })
                .store(in: &bag)
    }

}
