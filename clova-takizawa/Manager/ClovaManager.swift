//
//  ClovaManager.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import Foundation

class ClovaManager {
    private init() {}

    static let shared = ClovaManager()

    var registerdClovas = [Clova]()
}
