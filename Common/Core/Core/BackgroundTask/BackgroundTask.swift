//
// Created by Shaban on 26/06/2021.
//

import BackgroundTasks

public class ScheduledBackgroundTask {
    private var task: BGTask? = nil
    let identifier: String
    let scheduleInterval: Double
    let handler: (BGTask) -> Void

    public init(identifier: String,
                scheduleInterval: Double,
                handler: @escaping (BGTask) -> ()) {
        self.identifier = identifier
        self.scheduleInterval = scheduleInterval
        self.handler = handler
    }

    public func start() {
        BGTaskScheduler.shared.register(
                forTaskWithIdentifier: identifier,
                using: nil
        ) { task in
            task.expirationHandler = {
                // cancel
            }

            self.handler(task)
            self.schedule()
        }
        schedule()
    }

    private func schedule() {
        do {
            let request = BGAppRefreshTaskRequest(identifier: identifier)
            request.earliestBeginDate = Date(timeIntervalSinceNow: scheduleInterval)
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
    }

}