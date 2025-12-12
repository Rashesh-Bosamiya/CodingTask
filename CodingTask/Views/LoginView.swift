//
//  LoginView.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import SwiftUI

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var viewModel: LoginViewModel = LoginViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(OutlinedTextFieldStyle(systemImage: "envelope"))
                .focused($focusedField, equals: .email)
                .textContentType(.emailAddress)
                .submitLabel(.continue)
                .autocorrectionDisabled()
                .onSubmit {
                    focusedField = .password
                }
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(OutlinedTextFieldStyle(systemImage: "key"))
                .focused($focusedField, equals: .password)
                .textContentType(.password)
                .submitLabel(.done)
            Button("Done") {
                isLoggedIn = true
            }
            .buttonStyle(.bordered)
            
            .disabled(!viewModel.isFormValid)
            .navigationTitle("Login")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
