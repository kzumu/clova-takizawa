//
//  DmViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DmViewController: UIViewController {
    static func make(user: User) -> DmViewController {
        let vc = DmViewController()
        vc.title = "ユーザ\(user.id)"
        vc.user = user
        return vc
    }

    private var tableView: UITableView!
    private var bottomView: ChatInputView!
    private var user: User!
    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 10000
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .interactive

        bottomView = ChatInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        bottomView.sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let me = self else { return }
                DmManager.shared.append(Dm.init(type: .text(me.bottomView.chatTextField.text ?? ""), time: Date(), user: User(id: -1)))
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        tableView.register(R.nib.dmPostCell)
        tableView.register(R.nib.dmMyChatViewCell)
        tableView.register(R.nib.dmYourChatViewCell)
    }

    override var inputAccessoryView: UIView? {
        return bottomView
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }
}

extension DmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DmManager.shared.find(by: user).count)
        return DmManager.shared.find(by: user).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dm = DmManager.shared.find(by: user)[indexPath.row]
        switch dm.type {
        case .like:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dmPostCell, for: indexPath)!
            cell.set(dm)
            return cell
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dmPostCell, for: indexPath)!
            cell.set(dm)
            return cell
        case .text(let str):
            if dm.isMine {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myChat, for: indexPath)!
                cell.updateCell(text: str, time: dm.timeDescription, isRead: false)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dmYourChatViewCell, for: indexPath)!
            cell.updateCell(text: str, time: dm.timeDescription)
            return cell
        }
    }
}
