//
// Created by Shaban on 23/06/2021.
//

import Foundation
import Moya

public protocol MoyaUnderlyingErrorHandler {
    func canHandle(error: Swift.Error, response: Response?) -> Bool
    func handle(error: Swift.Error, response: Response?, presentable: Presentable?)
}
