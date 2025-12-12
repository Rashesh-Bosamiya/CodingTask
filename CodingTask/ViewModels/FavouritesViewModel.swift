//
//  FavouritesViewModel.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Observation

@Observable
class FavouritesViewModel {
    
    var favPosts: [Post] = []
    var viewState: ViewState = .data
    @ObservationIgnored private var realmManager: RealmManager = RealmManager()
    
    func getFavPosts() {
        defer {
            if favPosts.isEmpty {
                viewState = .noData
            } else {
                viewState = .data
            }
        }
        favPosts = realmManager.getFavPosts.map({ $0.objPost })
    }
    
    func removeFav(_ obj: Post) {
        realmManager.removeFav(post: obj)
        getFavPosts()
    }
}
