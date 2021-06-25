//
// Created by Shaban on 23/06/2021.
//

import Foundation
import Moya

public protocol MoyaStatusCodeHandler {
    var supportedErrorCodes: [Int] { get set }
    func canHandle(error: MoyaError) -> Bool
    func handle(error: MoyaError, presentable: Presentable?)
}

public extension MoyaStatusCodeHandler {
    func canHandle(error: MoyaError) -> Bool {
        let supportedError = supportedErrorCodes.first(where: { $0 == error.response!.statusCode })
        return supportedError != nil
    }
}