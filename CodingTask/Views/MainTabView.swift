//
//  MainTabView.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import SwiftUI

struct MainTabView: View {
    
    enum TabSelection: Hashable {
        case posts, favourites
        var navTitle: String {
            switch self {
            case .posts:
                "Posts"
            case .favourites:
                "Favourites"
            }
        }
    }
    
    @State private var currentTab: TabSelection = .posts
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some View {
        TabView(selection: $currentTab) {
            Tab("Post", systemImage: "doc.text", value: .posts) {
                PostsView()
            }
            Tab("Favourites", systemImage: "star.fill", value: .favourites) {
                FavouritesView()
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Logout") {
                    isLoggedIn = false
                }
            }
        }.navigationTitle(currentTab.navTitle)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MainTabView()
}
