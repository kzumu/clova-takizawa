//
//  DMManager.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import Foundation

class DmManager {
    private init() {}

    static let shared = DmManager()
    private var dms = [Dm]()

    func find(by user: User) -> [Dm] {
        return dms.filter { $0.user == user}
    }

    var getUserIds: [Int] {
        let users: [Int] = dms.map {
            $0.user.id
        }
        return Set(users).flatMap { (i) -> [Int] in
            return [i]
        }
    }

    func append(_ dm: Dm) {
        dms.append(dm)
    }
}
