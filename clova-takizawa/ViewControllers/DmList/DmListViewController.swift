//
//  DmListViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit
import RxSwift

class DmListViewController: UIViewController {
    static func make() -> DmListViewController {
        let vc = DmListViewController()
        vc.title = "DM"
        return vc
    }

    private var tableView: UITableView!
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
    }
}

extension DmListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DmManager.shared.getUsers().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = DmManager.shared.getUsers()[indexPath.row]
        cell.textLabel?.text = "ユーザ\(user.id)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = DmManager.shared.getUsers()[indexPath.row]
        let vc = DmViewController.make(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}
