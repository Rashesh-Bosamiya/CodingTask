//
//  Comment.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import RealmSwift

struct Comment: Codable, Identifiable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case id, postId, name, email, body
    }
}

class RealmComment: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var postId: Int
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var body: String
    
    static func transform(obj: Comment) -> RealmComment {
        let rObj = RealmComment()
        rObj.id = obj.id
        rObj.postId = obj.postId
        rObj.name = obj.name
        rObj.email = obj.email
        rObj.body = obj.body
        return rObj
    }
}
