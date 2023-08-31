//
//  Menu.swift
//  Quiz
//
//  Created by Gustavo Binder on 01/08/23.
//

import SwiftUI
import GameKit

struct Menu: View {
    
    @Namespace var namespace
    
    @EnvironmentObject var gcmanager : GCManager
    @EnvironmentObject var sceneManager : SceneManager
    
    @State var score : Int = 0
    @State var bestScore : String = ""
    
    let localPlayer = GKLocalPlayer.local
    
    var body: some View {
        ZStack {
            
            Color("BGColor")
                .ignoresSafeArea()
            
            VStack() {
                if sceneManager.currentScene == .menu {
                    HStack {
                        Image("Vines")
                            .frame(width: 350)
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .edgesIgnoringSafeArea(.top)
                    
                    Image("Sign")
                        .transition(.scale)
                        .beat(to: CGSize(width: 0.85, height: 0.85))
                    
                    VStack(spacing: 8) {
                        Button {
                            withAnimation {
                                sceneManager.currentScene = .game
                            }
                        } label: {
                            Text("Begin")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.accentColor)
                                .frame(width: 225)
                        }
                        Button {
                            withAnimation {
                                sceneManager.currentScene = .leaderboards
                            }
                        } label: {
                            Text("Leaderboard")
                                .font(.callout)
                                .frame(width: 150)
                        }
                    }
                    
                    Spacer()
                    
                    Image("UltraPile")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.bottom)
                } else if sceneManager.currentScene == .game {
                    ContentView(points: $score)
                        .transition(.scale)
                } else if sceneManager.currentScene == .leaderboards {
                    LeaderboardView()
                        .transition(.scale)
                } else if sceneManager.currentScene == .end {
                    EndScreen(points: score)
                        .transition(.asymmetric(insertion: .identity, removal: .slide))
                }
                
            }
        }
        .task {
            await gcmanager.loadLeaderboard()
        }
        .onAppear {
            SoundManager.playSound("song", type: "mp3", loops: 100)
        }
    }
}
