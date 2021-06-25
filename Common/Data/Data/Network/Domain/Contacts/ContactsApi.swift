//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import Moya

typealias ContactsApiProvider = MoyaProvider<ContactsApi>

enum ContactsApi {
    case contacts
}

extension ContactsApi: MoyaTargetType {

    public var path: String {
        switch self {
        case .contacts:
            return "/promotions"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .contacts:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .contacts:
            let params: [String: Any] = ["query": ""]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}

