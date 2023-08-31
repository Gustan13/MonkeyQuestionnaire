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
    @StateObject var sceneManager : SceneManager = SceneManager()
    
    var body: some Scene {
        WindowGroup {
            if !gcmanager.authenticated {
                LoadingView()
                    .environmentObject(gcmanager)
                    .preferredColorScheme(.light)
            } else {
                Menu()
                    .transition(.move(edge: .top))
                    .environmentObject(gcmanager)
                    .environmentObject(sceneManager)
                    .preferredColorScheme(.light)
            }
        }
    }
}
