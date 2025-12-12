//
//  APIService.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Alamofire
import Foundation

protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
    func fetchComments(for postId: Int) async throws -> [Comment]
}


struct APIService: APIServiceProtocol {
    
    func fetchPosts() async throws -> [Post] {
        try await request(endPoint: .posts)
    }
    
    func fetchComments(for postId: Int) async throws -> [Comment] {
        try await request(endPoint: .comments(postId: postId))
    }
    
    private func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        try await withCheckedThrowingContinuation { cont in
            AF.request(endPoint.url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        cont.resume(returning: data)
                    case .failure(let error):
                        cont.resume(throwing: error)
                    }
                }
        }
    }
}
