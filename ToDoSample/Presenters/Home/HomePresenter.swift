//
//  HomePresenter.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

// presenterではUIKitは利用しない！UIKitはViewControllerの中でのみ用いる。UIとロジックの分離。

// ViewControllerから受ける通知
protocol HomePresenterInput: class {
    func fetchPosts()
    func deletePost(at: Int)
    func logOut()
}

// ViewControllerへ送る通知
protocol HomePresenterOutput: class {
    func didFetchPosts()
    func didUpdatePosts()
    func didLogOut()
    func willShowAlert(_ alert: Alert)
}


class HomePresenter: HomePresenterInput {

    // delegateのようにViewControllerに通知を送るためのもの
    private weak var view: HomePresenterOutput!

    init(view: HomePresenterOutput) {
        self.view = view
        FirebasePostRepository.shared.delegate = self
        FirebaseAuthRepository.shared.delegate = self
    }

    // ViewControllerで表示するための情報はpresenterで保有する
    var posts: [Post] = []


    func fetchPosts() {
        FirebasePostRepository.shared.fetchPosts()
    }

    func deletePost(at index: Int) {
        FirebasePostRepository.shared.deletePost(posts[index].taskID)
    }

    func logOut() {
        FirebaseAuthRepository.shared.logOut()
    }


}

extension HomePresenter: FirebasePostRepositoryDelegate {
    func didCreatePost() {

    }

    func didReadPosts(_ posts: [Post]) {
        view.didFetchPosts()
    }

    func didUpdatePost() {
        view.didUpdatePosts()
    }

    func didDeletePost() {
        view.didUpdatePosts()
    }

    func didPostError(_ alert: Alert) {
        view.willShowAlert(alert)
    }
}

extension HomePresenter: FirebaseAuthRepositoryDelegate {
    func didSignUp() {
    }

    func didLogin() {
    }

    func didLogout() {
        view.didLogOut()
    }

    func didAuthError(_ alert: Alert) {
        view.willShowAlert(alert)
    }


}

