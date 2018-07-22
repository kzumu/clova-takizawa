//
//  PairCaleError.swift
//  pair-cale
//
//  Created by 下村一将 on 2018/04/12.
//  Copyright © 2018年 Kazumasa Shimomura. All rights reserved.
//

import Foundation

enum AppError: Error {
    case connection
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .connection:
            return "Network error"
        }
    }
}
