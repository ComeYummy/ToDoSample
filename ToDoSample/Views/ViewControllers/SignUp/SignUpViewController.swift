//
//  SignUpViewController.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    private var presenter: SignUpPresenter!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpPresenter()
    }

    // UI設定
    private func setUpUI() {
        passwordTextField.isSecureTextEntry = true
    }

    // Presenterをつくる
    private func setUpPresenter() {
        presenter = SignUpPresenter(view: self)
    }

    @IBAction func didTapSignUpButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.didTapSignUpButton(email: email, password: password)
    }

    @IBAction func didTapLogInButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.didTapLogInButton(email: email, password: password)
    }
}

// delegateのようにPresenterから通知を受けて動くメソッド
extension SignUpViewController: SignUpPresenterOutput {
    func didSignUp() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = AppRootViewController()
        //        let vc = HomeViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
    }
    
    func didLogIn() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = AppRootViewController()
        //        let vc = HomeViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
    }

    func willShowAlert(_ alert: Alert) {
        //UIAlertControllerを、関数の引数であるtitleとmessageを使ってインスタンス化
        let alertVC = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        //UIAlertActionを追加
        alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        //表示
        self.present(alertVC, animated: true, completion: nil)
    }


}
