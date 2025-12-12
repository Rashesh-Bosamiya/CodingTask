//
//  Post.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import RealmSwift
internal import Realm

struct Post: Codable, Equatable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    var isFavourite: Bool = false
    
    init(_ obj: RealmPost) {
        self.userId = obj.userId
        self.id = obj.id
        self.title = obj.title
        self.body = obj.body
        self.isFavourite = obj.isFavourite
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.body, forKey: .body)
        try container.encode(self.isFavourite, forKey: .isFavourite)
    }
    
    enum CodingKeys: CodingKey {
        case userId, id, title, body, isFavourite
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.isFavourite = false
    }
}

class RealmPost: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var userId: Int
    @Persisted var body: String
    @Persisted var isFavourite: Bool = false
    
    var objPost: Post {
        Post(self)
    }
    
    static func transform(obj: Post) -> RealmPost {
        let rObj = RealmPost()
        rObj.id = obj.id
        rObj.userId = obj.userId
        rObj.title = obj.title
        rObj.body = obj.body
        rObj.isFavourite = obj.isFavourite
        return rObj
    }
}
