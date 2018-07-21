//
//  DmListViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class DmListViewController: UIViewController {
    static func make() -> DmListViewController {
        let vc = DmListViewController()
        vc.title = "DM"
        return vc
    }

    private var tableView: UITableView!

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
        return DmManager.shared.getUserIds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let id = DmManager.shared.getUserIds[indexPath.row]
        cell.textLabel?.text = "ユーザ\(id)"
        return cell
    }
}
