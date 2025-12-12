//
//  PostCell.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 12/12/25.
//

import SwiftUI

struct PostCell: View {
    var obj: Post
    
    init(_ obj: Post) {
        self.obj = obj
    }
    
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text(obj.title)
                    .font(.headline)
                Text(obj.body)
                    .font(.footnote)
            }
        } icon: {
            Image(systemName: obj.isFavourite ? "star.fill" : "star")
                .symbolEffect(obj.isFavourite ? .bounce.up : .bounce.down, value: obj.isFavourite)
                .foregroundStyle(.pink)
        }
    }
}
