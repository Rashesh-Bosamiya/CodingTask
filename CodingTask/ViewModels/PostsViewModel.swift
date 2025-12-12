//
//  PostsViewModel.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Foundation
import Observation

@Observable
class PostsViewModel {
    
    @ObservationIgnored private var apiService: APIService = APIService()
    @ObservationIgnored private var realmManager: RealmManager = RealmManager()
    @ObservationIgnored private var didLoad: Bool = false
    var posts: [Post] = []
    var viewState: ViewState = .data {
        didSet {
            if viewState == .data {
                didLoad = true
            }
        }
    }
    
    func getPosts(isPullToRefersh: Bool = false) async {
        if didLoad && !isPullToRefersh {
            getLocalSaved()
            return
        }
        if !isPullToRefersh {
            viewState = .loading
        }
        do {
            let newPosts = try await apiService.fetchPosts()
            let savedPosts = realmManager.savePosts(newPosts)
            posts = savedPosts.map(\.objPost)
            viewState = .data
            if posts.isEmpty {
                viewState = .noData
            } else {
                viewState = .data
            }
        } catch {
            getLocalSaved()
            if posts.isEmpty {
                viewState = .error
            } else {
                viewState = .data
            }
        }
    }
    
    private func getLocalSaved() {
        let localSavedPosts = Array(realmManager.getPosts).map(\.objPost)
        posts = localSavedPosts
    }
    
    func toggleFav(_ obj: Post) {
        if let i = posts.firstIndex(of: obj) {
            posts[i].isFavourite.toggle()
            realmManager.toggleFavourite(post: posts[i])
        }
    }
}
