//
//  RealmManager.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    
    @discardableResult
    func savePosts(_ posts: [Post]) -> [RealmPost] {
        var arr: [RealmPost] = []
        let existing = getPosts
        try! realm.write({
            for post in posts {
                if let local = existing.first(where: { $0.id == post.id }) {
                    arr.append(local)
                } else {
                    let obj = RealmPost.transform(obj: post)
                    realm.add(obj, update: .modified)
                    arr.append(obj)
                }
            }
        })
        return arr
    }
    
    @discardableResult
    func saveComments(_ comments: [Comment]) -> [RealmComment] {
        var arr: [RealmComment] = []
        try! realm.write({
            for comment in comments {
                let obj = RealmComment.transform(obj: comment)
                realm.add(obj, update: .modified)
                arr.append(obj)
            }
        })
        return arr
    }
    
    var getPosts: Results<RealmPost> {
        realm.objects(RealmPost.self)
    }
    
    var getFavPosts: Results<RealmPost> {
        getPosts.filter("isFavourite = %@", true)
    }
    
    func toggleFavourite(post: Post) {
        if let first = getPosts.first(where: { $0.id == post.id }) {
            try! realm.write {
                first.isFavourite = post.isFavourite
            }
        }
    }
    
    func removeFav(post: Post) {
        if let first = getPosts.first(where: { $0.id == post.id }) {
            try! realm.write {
                first.isFavourite = false
            }
        }
    }
}
