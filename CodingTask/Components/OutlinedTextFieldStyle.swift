//
//  OutlinedTextFieldStyle.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 12/12/25.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    
    private var systemImage: String?

    init(systemImage: String) {
        self.systemImage = systemImage
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundColor(Color(UIColor.systemGray4))
            }
            configuration
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
        }
    }
}
