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
    }

    // ViewControllerで表示するための情報はpresenterで保有する
    private(set) var posts: [Post] = []


    func fetchPosts() {
        FirebasePostRepository.shared.fetchPosts() { posts, alert in
            if let alert = alert {
                // エラーの場合
                self.view.willShowAlert(alert)
            } else {
                // 成功
                self.posts = posts
                self.view.didFetchPosts()
            }
        }
    }

    func deletePost(at index: Int) {
        FirebasePostRepository.shared.deletePost(posts[index].taskID) { alert in
            self.posts.remove(at: index)
            self.view.didUpdatePosts()
        }
    }

    func logOut() {
        FirebaseAuthRepository.shared.logOut()  { alert in
            if let alert = alert {
                // エラーの場合
                self.view.willShowAlert(alert)
            } else {
                // 成功
                self.view.didLogOut()
            }
        }

    }
}
