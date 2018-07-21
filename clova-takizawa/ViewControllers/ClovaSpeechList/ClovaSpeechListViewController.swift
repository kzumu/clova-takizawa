//
//  ClovaSpeechListViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class ClovaSpeechListViewController: UIViewController {
    static func make(eventName: String, chats: [Chat]) -> ClovaSpeechListViewController {
        let vc = R.storyboard.clovaSpeechList.instantiateInitialViewController()!
        vc.title = eventName
        vc.eventName = eventName
        return vc
    }

    let chatManager = ChatManager.shared
    @IBOutlet weak var tableView: UITableView!
    var eventName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ClovaSpeechListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatManager.getChats(eventName: eventName).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let chats = chatManager.getChats(eventName: eventName)
        cell.textLabel?.text = chats[indexPath.row].text
        cell.detailTextLabel?.text = chats[indexPath.row].time
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chats = chatManager.getChats(eventName: eventName)
        let chat = chats[indexPath.row]
        let sheet = UIAlertController(title: "以下のメッセージを選択しています", message: chat.text, preferredStyle: .actionSheet)
        sheet.addAction(.init(title: "いいね", style: .default, handler: { (_) in
            print("いいね")
        }))
        sheet.addAction(.init(title: "返信", style: .default, handler: { (_) in
            print("返信")
        }))
        present(sheet, animated: true, completion: nil)
    }
}
