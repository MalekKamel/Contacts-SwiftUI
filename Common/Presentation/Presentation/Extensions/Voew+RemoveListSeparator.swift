//
// Created by Shaban Kamel on 01/04/2021.
//

import SwiftUI

import SwiftUI

struct RemoveListSeparator: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
    }
}

public extension View {
    func removeListSeparator() -> some View {
        ModifiedContent(content: self, modifier: RemoveListSeparator())
    }
}

