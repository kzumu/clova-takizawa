//
//  ViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TopViewController: UIViewController {
    static func make() -> TopViewController {
        return R.storyboard.topViewController.instantiateInitialViewController()!
    }

    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    @IBAction func addEventButtonTapped(_ sender: Any) {
        let vc = AddClovaViewController.make()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func messageButtonTapped(_ sender: Any) {
        let vc = DmListViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClovaManager.shared.registerdClovas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ClovaManager.shared.registerdClovas[indexPath.row].eventName
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let chats = [
//            Chat(text: "hoge", time: "12:34", eventName: "<#String#>"),
//            Chat(text: "hoge", time: "12:34"),
//            Chat(text: "hoge", time: "12:34"),
//        ]
        let vc = ClovaSpeechListViewController.make(eventName: ClovaManager.shared.registerdClovas[indexPath.row].eventName, chats: [])
        navigationController?.pushViewController(vc, animated: true)
    }
}

