//
//  APIEndPoint.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

enum Endpoint {
    static private let baseURL = "https://jsonplaceholder.typicode.com"
    case posts
    case comments(postId: Int)
    
    var url: String {
        switch self {
        case .posts:
            Self.baseURL + "/posts"
        case .comments(let postId):
            Self.baseURL + "posts/\(postId)/comments"
        }
    }
}
