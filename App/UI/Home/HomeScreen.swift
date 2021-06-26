//
//  HomeScreen.swift
//
//  Created by Shaban kamel on 30/3/21.
//

import SwiftUI

struct HomeScreen: AppScreen {
    @ObservedObject var vm: HomeVM
    @State public var route: Route? = nil

    func ContentView() -> AnyView {
        ScrollView(showsIndicators: false) {
            ForEach(vm.contacts) { item in
                VStack {
                    Text(item.name)
                    Text(item.phone)
                }
                        .frame(height: 70)
            }
        }.frame(maxWidth: .infinity)
                .eraseToAnyView()
    }

    func onContentAppear() {
        loadContacts()
    }

    private func loadContacts() {
        ContactsRetriever().grantPermission { isGranted in
            vm.loadContacts()
        }
    }
}

extension HomeScreen {
    enum Route: AppRoute {
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeVM.build()
        HomeScreen(vm: vm).environmentObject(vm)
    }
}
