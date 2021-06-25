//
// Created by Shaban Kamel on 31/03/2021.
//

import SwiftUI

public struct DotIndicator: View {
    let minScale: CGFloat = 1
    let maxScale: CGFloat = 1.1
    let minOpacity: Double = 0.6

    let pageIndex: Int
    @Binding var selectedPage: Int

    public init(pageIndex: Int, selectedPage: Binding<Int>) {
        self.pageIndex = pageIndex
        self._selectedPage = selectedPage
    }

    public var body: some View {
        Button(action: {
            self.selectedPage = pageIndex
        }) {
            Circle()
                    .scaleEffect(
                            selectedPage == pageIndex
                                    ? maxScale
                                    : minScale
                    )
                    .animation(.spring())
                    .foregroundColor(
                            selectedPage == pageIndex
                                    ? Color.white
                                    : Color.white.opacity(minOpacity)
                    )
        }

    }
}

// MARK: - Page Indicator -
public struct PageIndicator: View {
    // Constants
    private let spacing: CGFloat = 2
    private let diameter: CGFloat = 8

    // Settings
    let numPages: Int
    @Binding var selectedIndex: Int

    public init(numPages: Int, currentPage: Binding<Int>) {
        self.numPages = numPages
        self._selectedIndex = currentPage
    }

    public var body: some View {
        VStack {
            HStack(alignment: .center, spacing: spacing) {
                ForEach((0..<numPages)) {
                    DotIndicator(
                            pageIndex: $0,
                            selectedPage: self.$selectedIndex
                    ).frame(
                            width: diameter,
                            height: diameter
                    )
                }
            }
        }
    }
}


// MARK: - Previews -
struct DotIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DotIndicator(pageIndex: 0, selectedPage: .constant(0))
                .previewLayout(.fixed(width: 200, height: 200))
                .previewDisplayName("Hello")
    }
}

struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicator(numPages: 5, currentPage: .constant(2))
                .previewDisplayName("Regular")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
    }
}