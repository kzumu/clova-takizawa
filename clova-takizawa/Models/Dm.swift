//
//  Dm.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import Foundation

enum DmType {
    case text(_: String)
    case like
}

struct Dm {
    let type: DmType
    let time: Date
    let user: User

    var timeDescription: String {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df.string(from: time)
    }
}
