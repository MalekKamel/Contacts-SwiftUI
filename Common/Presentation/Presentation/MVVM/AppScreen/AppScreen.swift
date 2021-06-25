//
// Created by Apple on 04/04/2021.
//

import SwiftUI
import Core

/// A protocol that abstracts the common functionalities of a screen
/// The screen represents the main container that covers all the device screen.
/// NOT a single component.
public protocol AppScreen: View {
    associatedtype ViewModel: AppViewModel
    associatedtype ScreenRoute: AppRoute

    /// The viewModel of this screen
    var vm: ViewModel { get set }

    var route: ScreenRoute? { get set }

    /// The main container for the whole screen
    /// - Returns: AnyView
    func BodyView() -> AnyView

    /// The normal content view that should be shown to
    /// the user in the normal state.
    /// - Returns: AnyView
    func ContentView() -> AnyView

    /// The screen loading view.
    /// - Returns: AnyView
    func LoadingView() -> AnyView

    /// Called when the root view appears.
    func onContentAppear()

    /// Called when the root view disappears.
    func onContentDisappear()

    /// Navigation links, added to the content for you.
    func NavigationLinks() -> AnyView
}

public extension AppScreen {

    var body: some View {
        ZStack {
            NavigationLinks()
            BodyView()
                    .onAppear(perform: onContentAppear)
                    .onDisappear(perform: onContentDisappear)
        }
    }

    func BodyView() -> AnyView {
        ContentView()
                .loadingIndicator(state: vm.loadState, loadingView: LoadingView())
                .eraseToAnyView()
    }

    func LoadingView() -> AnyView {
        Spinner(isAnimating: true, style: .large, color: .black).eraseToAnyView()
    }

    func onContentAppear() {
    }

    func onContentDisappear() {
    }

    func NavigationLinks() -> AnyView {
        EmptyView().eraseToAnyView()
    }

}

