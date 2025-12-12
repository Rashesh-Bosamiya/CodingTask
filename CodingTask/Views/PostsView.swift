//
//  PostsView.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import SwiftUI

struct PostsView: View {
    
    @State private var viewModel = PostsViewModel()
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                ProgressView {
                    Text("Loading")
                }
            case .noData:
                ContentUnavailableView("No Posts",
                                       systemImage: "tray",
                                       description: Text("no content yet"))
            case .error:
                ContentUnavailableView("No Posts",
                                       systemImage: "icloud.slash",
                                       description: Text("Error occured while loading the posts"))
            case .data:
                List(viewModel.posts, id: \.id) { row in
                    PostCell(row)
                        .onTapGesture {
                            viewModel.toggleFav(row)
                        }
                }
                .refreshable {
                    await viewModel.getPosts(isPullToRefersh: true)
                }
            }
        }.task {
            await viewModel.getPosts()
        }
    }
}

#Preview {
    PostsView()
}
