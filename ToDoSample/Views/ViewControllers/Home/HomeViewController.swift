//
//  HomeViewController.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var presenter: HomePresenter!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavigationBar() 
        setUpTableView()
        setUpPresenter()

        fetchPosts()
    }

    private func setUpUI() {

    }

    private func setUpNavigationBar() {
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddScreen))
        navigationItem.rightBarButtonItem = rightButtonItem
        //画面上部のナビゲーションバーの左側にログアウトボタンを設置し、押されたらlogOut関数が走るように設定
        let leftButtonItem = UIBarButtonItem(title: "ログアウト", style: .done, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = leftButtonItem
    }

    private func setUpTableView() {
        // tableViewのお約束その１。この ViewController で delegate のメソッドを使うために記述している。
        tableView.delegate = self
        // tableViewのお約束その２。この ViewController で datasouce のメソッドを使うために記述している。
        tableView.dataSource = self

        // CustomCellの登録。忘れがちになるので注意！！
        // nibの読み込み。nib と xib はほぼ一緒
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
    }

    // Presenterをつくる
    private func setUpPresenter() {
        presenter = HomePresenter(view: self)
    }

    // PostsをFirebaseから取得するためにpresenterへ通知
    private func fetchPosts() {
        presenter.fetchPosts()
    }

    // navigation barのaddボタンをタップされたときの動作
    @objc func showAddScreen() {
        let vc = AddPostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func logOut(){
        presenter.logOut()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 登録したセルを使う。 as! CustomCell としないと、UITableViewCell のままでしか使えない。
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        if !presenter.posts.isEmpty {
            //tasksの要素が存在するときのみ下記コードが呼ばれる
            cell.titleLabel?.text = presenter.posts[indexPath.row].title
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskDetailViewController()
//        vc.selectIndex = indexPath.row
//        vc.posts = posts
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.deletePost(at: indexPath.row)
    }

}

extension HomeViewController: HomePresenterOutput {

    func didFetchPosts() {
        tableView.reloadData()
    }

    func didUpdatePosts() {
        tableView.reloadData()
    }

    func didLogOut() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = AppRootViewController()
    }

    func willShowAlert(_ alert: Alert) {
        let alertVC = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        //UIAlertActionを追加
        alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        //表示
        self.present(alertVC, animated: true, completion: nil)
    }


}
