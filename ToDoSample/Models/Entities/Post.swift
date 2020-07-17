//
//  Post.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Post のクラス。
struct Post: Codable {
    //Task単位で1つのDocumentになるため、idを持たせる
    let taskID: String
    var title: String
    var memo: String?
    //サーバーへの書き込み日時を持たせる（モデルを作る際のお作法的な要素もあるが、並び替えにも役立つ）
    let createdAt: Timestamp
    var updatedAt: Timestamp
}

