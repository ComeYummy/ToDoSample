//
//  AppRootViewController.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import UIKit

class AppRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // ログアウト時にAppRootViewControllerに戻すため、表示のたびに動作するviewDidAppearを利用する
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if FirebaseAuthRepository.shared.isLogIn {
            // ログイン状態のとき
            let vc = HomeViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        } else {
            // ログアウト状態のとき
            let vc = SignUpViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }

}
