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
        VStack {
            Image("Monkey1")
                .wiggle(true, 15.0, 0.2)
                .matchedGeometryEffect(id: "monkey", in: namespace)
            
            Image("Title")
                .beat(to: CGFloat(0.78))
            
            HStack {
                Image("Monkey2")
                    .wiggle(false, 10, 0.2)
                Spacer()
                Image("Monkey3")
                    .wiggle(true, 10, 0.2)
            }
            .padding(.horizontal)
            ZStack {
                Color(uiColor: .lightGray)
                    .opacity(0.78)
                    .cornerRadius(20)
                    .ignoresSafeArea()
                VStack {
                    Button {
                        withAnimation {
                            sceneManager.currentScene = .game
                        }
                    } label: {
                        Text("Begin")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 225)
                            .background {
                                Color.white
                                    .opacity(0.5)
                            }
                            .cornerRadius(12)
                    }
                    Button {
                        withAnimation {
                            sceneManager.currentScene = .leaderboards
                        }
                    } label: {
                        Text("Leaderboard")
                            .bold()
                            .font(.callout)
                            .padding(6)
                            .frame(width: 150)
                            .background {
                                Color.white
                                    .opacity(0.5)
                            }
                            .cornerRadius(8)
                    }
                }
            }
            .task {
                await gcmanager.loadLeaderboard()
            }
        }
    }
}
