//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import Combine
import Moya

class ContactsDataSrc {
    let api: ContactsApiProvider

    init(api: ContactsApiProvider) {
        self.api = api
    }

}