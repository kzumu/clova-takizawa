//
//  AddClovaViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class AddClovaViewController: UIViewController {
    static func make() -> AddClovaViewController {
        return R.storyboard.addClovaViewController.instantiateInitialViewController()!
    }

    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var clovaIdField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        ClovaManager.shared.registerdClovas.append(Clova(eventName: eventNameField.text ?? "", clovaId: clovaIdField.text ?? ""))
        navigationController?.popToRootViewController(animated: true)
    }
}
