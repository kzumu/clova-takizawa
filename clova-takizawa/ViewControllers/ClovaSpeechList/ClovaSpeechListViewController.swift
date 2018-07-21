//
//  ClovaSpeechListViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ClovaSpeechListViewController: UIViewController {
    static func make(eventName: String, chats: [Chat]) -> ClovaSpeechListViewController {
        let vc = R.storyboard.clovaSpeechList.instantiateInitialViewController()!
        vc.title = eventName
        vc.eventName = eventName
        return vc
    }

    @IBOutlet weak var tableView: UITableView!
    var bottomView: ChatInputView!

    let chatManager = ChatManager.shared
    var eventName: String!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView = ChatInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        bottomView.sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let me = self else { return }
                me.chatManager.appendChats(
                    Chat(text: me.bottomView.chatTextField.text ?? "",
                         time: Date(), eventName: me.eventName, likeCount: 0
                    ))
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    override var inputAccessoryView: UIView? {
        return bottomView
    }

    override var canBecomeFirstResponder: Bool {
        return true
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
        cell.detailTextLabel?.text = chats[indexPath.row].timeDescription
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chats = chatManager.getChats(eventName: eventName)
        var chat = chats[indexPath.row]
        let sheet = UIAlertController(title: "以下のメッセージを選択しています", message: chat.text, preferredStyle: .actionSheet)
        sheet.addAction(.init(title: "いいね", style: .default, handler: { [weak self] (_) in
            chat.likeCount += 1
            let newChats = chats.update(chat: chat)
            self?.chatManager.chats = newChats
            print("いいね")
            self?.tableView.reloadData()
        }))
        sheet.addAction(.init(title: "返信", style: .default, handler: { (_) in
            print("返信")
        }))
        sheet.addAction(.init(title: "閉じる", style: .default, handler: nil))
        present(sheet, animated: true, completion: nil)
    }
}