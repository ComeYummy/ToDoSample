//
//  User.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable {
    //ユーザーID
    let userID: String
    //名前
    var name: String
    //年齢
    var age: String
    //作成日時
    let createdAt: Timestamp
    //更新日時
    var updatedAt: Timestamp
}
