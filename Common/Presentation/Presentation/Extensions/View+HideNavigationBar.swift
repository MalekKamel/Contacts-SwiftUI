//
// Created by Shaban on 23/06/2021.
//

import SwiftUI

public extension View {
    func hideNavigationBar() -> some View {
        self
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
    }
}
