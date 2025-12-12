//
//  CodingTaskApp.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import SwiftUI
import Observation

@main
struct CodingTaskApp: App {

    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
        }
    }
}
