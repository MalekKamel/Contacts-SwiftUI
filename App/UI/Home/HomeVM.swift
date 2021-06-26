//
// Created by Shaban Kamel on 01/04/2021.
//

import Combine
import Moya

class HomeVM: AppViewModel {
    @Published public var loadState: LoadingState = .init()
    public var bag = CancelableBag()
    public var dataManager: DataManager
    public var requester: CombineRequester

    @Published private(set) var contacts = [ContactItem]()

    init(dataManager: DataManager, requester: CombineRequester) {
        self.dataManager = dataManager
        self.requester = requester
    }

    func loadContacts() {
        request(dataManager.contactsRepo.contacts())
                .sink(receiveValue: { value in
                    self.contacts = value
                })
                .store(in: &bag)
    }

}


extension HomeVM {
    static func build() -> HomeVM {
        HomeVM(dataManager: DataManager.create(),
                requester: CombineRequester())
    }
}