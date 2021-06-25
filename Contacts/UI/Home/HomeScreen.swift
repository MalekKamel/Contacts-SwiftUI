//
//  FreshRecipesView.swift
//
//  Created by Shaban kamel on 30/3/21.
//

import SwiftUI

struct HomeScreen: AppScreen {
    @ObservedObject var vm: HomeVM
    @State public var route: Route? = nil

    func ContentView() -> AnyView {
        EmptyView().eraseToAnyView()
    }

    func onContentAppear() {

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
