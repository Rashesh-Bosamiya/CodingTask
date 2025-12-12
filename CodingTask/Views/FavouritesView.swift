//
//  FavouritesView.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import SwiftUI

struct FavouritesView: View {
    
    @State private var viewModel: FavouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .noData:
                ContentUnavailableView("No favourite posts",
                                       systemImage: "tray",
                                       description: Text("no content yet"))
            default:
                List(viewModel.favPosts, id: \.id) { row in
                    PostCell(row)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                viewModel.removeFav(row)
                            }
                        }
                }
            }
        }
        .onAppear {
            viewModel.getFavPosts()
        }
    }
}
