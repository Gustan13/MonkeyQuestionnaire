//
//  MainView.swift
//  Quiz
//
//  Created by Gustavo Binder on 04/08/23.
//

import SwiftUI

struct MainView: View {
    
    @Namespace var namespace
    
    @EnvironmentObject var gcmanager : GCManager
    @StateObject var sceneManager = SceneManager()
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            switch (sceneManager.currentScene) {
                
            case .menu:
                Menu()
                    .transition(.opacity)
                    .environmentObject(sceneManager)
                    .matchedGeometryEffect(id: "scene", in: namespace)
            case .game:
                ContentView()
                    .environmentObject(sceneManager)
                    .matchedGeometryEffect(id: "scene", in: namespace)
            case .leaderboards:
                LeaderboardView()
                    .environmentObject(sceneManager)
                    .matchedGeometryEffect(id: "scene", in: namespace)
            }
        }
        .onAppear {
            SoundManager.playSound("song", type: "mp3", loops: 100)
        }
    }
}

