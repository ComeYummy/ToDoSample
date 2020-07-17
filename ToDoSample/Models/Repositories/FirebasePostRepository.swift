//
//  FirebasePostRepository.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebasePostRepository {

    // シングルトン実装
    static var shared: FirebasePostRepository = FirebasePostRepository()

    private init() {}

    // FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()

    let postsCollectionName = "Posts"

    func fetchPosts(completion: @escaping ([Post], Alert?) -> Void) {
        //作成日時の降順に並べ替えて取得する
        db.collection(postsCollectionName).order(by: "createdAt", descending: true).getDocuments { (querySnapShot, error) in
            if let error = error as NSError? {
                guard let alert = self.convertToErrorAlert(error) else { return }
                completion([], alert)
            } else {
                //データ取得に成功
                var posts: [Post] = []
                //取得したDocument群の1つ1つのDocumentについて処理をする
                for document in querySnapShot!.documents{
                    //各DocumentからはDocumentIDとその中身のdataを取得できる
                    print("\(document.documentID) => \(document.data())")
                    //型をTask型に変換
                    do {
                        let decodedPost = try Firestore.Decoder().decode(Post.self, from: document.data())
                        //変換に成功
                        posts.append(decodedPost)
                    } catch let error as NSError{
                        print("decode失敗エラー:\(error)")
                    }
                }
                completion(posts, nil)
            }
        }
    }

    func deletePost(_ taskID: String, completion: @escaping (Alert?) -> Void) {
        db.collection(postsCollectionName).document(taskID).delete()
        completion(nil)
    }


    private func convertToErrorAlert(_ error: NSError) -> Alert? {
        let message = "エラー: \(error.localizedDescription)"
        return Alert(title: "エラー", message: message)
    }
}
