//
//  SignUpPresenter.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

// presenterではUIKitは利用しない！UIKitはViewControllerの中でのみ用いる。UIとロジックの分離。

// ViewControllerから受ける通知
protocol SignUpPresenterInput: class {
    func didTapSignUpButton(email: String, password: String)
    func didTapLogInButton(email: String, password: String)
}

// ViewControllerへ送る通知
protocol SignUpPresenterOutput: class {
    func didSignUp()
    func didLogIn()
    func willShowAlert(_ alert: Alert)
}

class SignUpPresenter: SignUpPresenterInput {

    // delegateのようにViewControllerに通知を送るためのもの
    private weak var view: SignUpPresenterOutput!

    init(view: SignUpPresenterOutput) {
        self.view = view
    }

    func didTapSignUpButton(email: String, password: String) {
        if let alert = validation(email: email, password: password) {
            // validationエラーの場合はalertをviewへ渡す
            view.willShowAlert(alert)
        } else {
            // validationエラーではない場合はRepositoryへ
            FirebaseAuthRepository.shared.signUp(email: email, password: password) { alert in
                if let alert = alert {
                    // エラーの場合
                    self.view.willShowAlert(alert)
                } else {
                    // 成功
                    self.view.didSignUp()
                }
            }
        }
    }

    func didTapLogInButton(email: String, password: String) {
        if let alert = validation(email: email, password: password) {
            // validationエラーの場合はalertをviewへ渡す
            view.willShowAlert(alert)
        } else {
            // validationエラーではない場合はRepositoryへ
            FirebaseAuthRepository.shared.logIn(email: email, password: password) { alert in
                if let alert = alert {
                    // エラーの場合
                    self.view.willShowAlert(alert)
                } else {
                    // 成功
                    self.view.didLogIn()
                }
            }
        }
    }

    private func validation(email: String, password: String) -> Alert? {
        if email.isEmpty && password.isEmpty{
            return Alert(title: "エラー", message: "メールアドレスとパスワードを入力して下さい")
        } else if email.isEmpty {
            return Alert(title: "エラー", message: "メールアドレスを入力して下さい")
        } else if password.isEmpty {
            return Alert(title: "エラー", message: "パスワードを入力して下さい")
        } else {
            //emailとメールアドレスのいずれも入力されていれば、新規登録処理
            return nil
        }
    }
}
