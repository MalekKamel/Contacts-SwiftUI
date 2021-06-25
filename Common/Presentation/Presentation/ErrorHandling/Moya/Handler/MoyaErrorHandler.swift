//
// Created by Shaban on 23/06/2021.
//

import Moya

public protocol MoyaErrorHandler {
    func canHandle(error: MoyaError) -> Bool
    func handle(error: MoyaError, presentable: Presentable?)
}