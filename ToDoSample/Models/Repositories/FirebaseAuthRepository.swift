//
//  FirebaseAuthRepository.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import FirebaseAuth

protocol FirebaseAuthRepositoryDelegate: class {
    func didSignUp()
    func didLogin()
    func didLogout()
    func didAuthError(_ alert: Alert)
}

class FirebaseAuthRepository {

    // シングルトン実装
    static var shared: FirebaseAuthRepository = FirebaseAuthRepository()
    // delegate利用
    weak var delegate: FirebaseAuthRepositoryDelegate?

    private init() {}

    // signUp
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            //NSError?型にキャストしたerrorをアンラップ
            if let error = error as NSError? {
                dump(error)
                //エラーをmessageへ変換
                guard let alert = self.convertToErrorAlert(error) else { return }
                //エラー時の処理
                self.delegate?.didAuthError(alert)
            } else {
                //成功時の処理
                self.delegate?.didSignUp()
            }
        }
    }

    // logIn
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            //NSError?型にキャストしたerrorをアンラップ
            if let error = error as NSError? {
                dump(error)
                //エラーをmessageへ変換
                guard let alert = self.convertToErrorAlert(error) else { return }
                //エラー時の処理
                self.delegate?.didAuthError(alert)
            } else {
                //成功時の処理
                self.delegate?.didLogin()
            }
        }
    }


    private func convertToErrorAlert(_ error: NSError) -> Alert? {
        //引数errorの持つcodeを使って、EnumであるAuthErrorCodeを呼び出し
        guard let errCode = AuthErrorCode(rawValue: error.code) else { return nil }
        //表示するメッセージを格納する変数を宣言
        var message = ""
        //errCodeの値によってメッセージを出しわけ
        switch errCode {
        //AuthErrorCode.invalidEmailといった書き方を省略
        case .invalidEmail:
            message =  "有効なメールアドレスを入力してください"
        case .emailAlreadyInUse:
            message = "既に登録されているメールアドレスです"
        case .weakPassword:
            message = "パスワードは６文字以上で入力してください"
        case .userNotFound:
            message = "アカウントが見つかりませんでした"
        case .wrongPassword:
            message = "パスワードを確認してください"
        case .userDisabled:
            message = "アカウントが無効になっています"
        default:
            message = "エラー: \(error.localizedDescription)"
        }
        return Alert(title: "認証エラー", message: message)
    }
}
