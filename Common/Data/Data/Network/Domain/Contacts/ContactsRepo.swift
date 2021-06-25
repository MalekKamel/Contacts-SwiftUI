//
// Created by Shaban Kamel on 01/04/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import ModelsMapper
import Combine
import Moya

public class ContactsRepo {
    let dataSrc: ContactsDataSrc

    public static func build() -> ContactsRepo {
        ContactsRepo(dataSrc: ContactsDataSrc(api: MoyaProvider<ContactsApi>.create()))
    }

    init(dataSrc: ContactsDataSrc) {
        self.dataSrc = dataSrc
    }

}