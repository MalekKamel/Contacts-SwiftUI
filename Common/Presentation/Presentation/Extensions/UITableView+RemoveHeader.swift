//
// Created by Shaban Kamel on 02/04/2021.
//

import UIKit

public extension UITableView {

    static func removeHeader() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableHeaderView = view
    }
}