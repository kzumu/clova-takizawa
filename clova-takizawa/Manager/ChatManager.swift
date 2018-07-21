//
//  ChatManager.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import Foundation

class ChatManager {
    private init() {}

    static let shared = ChatManager()

    var chats = [Chat]()

    func getChats(eventName: String) -> [Chat] {
        return chats.filter { $0.eventName == eventName }
    }

    func appendChats(_ chat: Chat) {
        chats.append(chat)
    }
}
