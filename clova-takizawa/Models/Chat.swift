//
//  Chat.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import Foundation

struct Chat {
    let text: String
    let time: Date
    let eventName: String
    var likeCount: Int
    let user: User

    var timeDescription: String {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df.string(from: time)
    }
}

extension Array where Element == Chat {
    func update(chat: Chat) -> [Chat] {
        let i = self.index {
            return $0.time == chat.time
        }
        var chats = self
        guard let index = i else {
            chats.append(chat)
            return chats
        }

        chats[index] = chat
        return chats
    }
}
