//
//  QuizApp.swift
//  Quiz
//
//  Created by Gustavo Binder on 31/07/23.
//

import SwiftUI

@main
struct QuizApp: App {
    @StateObject var gcmanager : GCManager = GCManager()
    
    var body: some Scene {
        WindowGroup {
            if !gcmanager.authenticated {
                LoadingView()
                    .environmentObject(gcmanager)
            } else {
                MainView()
                    .transition(.move(edge: .top))
                    .environmentObject(gcmanager)
            }
        }
    }
}
