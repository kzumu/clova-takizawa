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

        bottomView = ChatInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        bottomView.sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let me = self else { return }
                DmManager.shared.append(Dm.init(type: .text(me.bottomView.chatTextField.text ?? ""), time: Date(), user: me.user))
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    override var inputAccessoryView: UIView? {
        return bottomView
    }
}

extension DmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DmManager.shared.getUserIds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let id = DmManager.shared.getUserIds[indexPath.row]
        cell.textLabel?.text = "ユーザ\(id)"
        return cell
    }
}
