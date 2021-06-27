//
// Created by Shaban Kamel on 01/04/2021.
//

import Combine
import Moya

class HomeVM: AppViewModel {
    @Published public var loadState: LoadingState = .init()
    public var bag = CancelableBag()
    public var dataManager: DataManagerContract
    public var requester: CombineRequester

    @Published private(set) var contacts = [ContactItem]()

    init(dataManager: DataManagerContract, requester: CombineRequester) {
        self.dataManager = dataManager
        self.requester = requester
    }

    func loadContacts() {
        request(dataManager.contactsRepo.contacts())
                .sink(receiveValue: { [weak self] value in
                    self?.contacts = value
                    self?.sync()
                })
                .store(in: &bag)
    }

    func sync() {
        request(dataManager.contactsRepo.sync())
                .sink(receiveValue: { [weak self] isModified in
                    guard let self = self else {
                        return
                    }
                    guard isModified else {
                        return
                    }
                    self.loadContacts()
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