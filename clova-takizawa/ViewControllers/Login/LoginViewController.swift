

//
//  LoginViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/22.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    static func make() -> LoginViewController {
        return R.storyboard.loginViewController.instantiateInitialViewController()!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController = UINavigationController(rootViewController:  TopViewController.make())
    }
}
