//
//  LeaderboardView.swift
//  Quiz
//
//  Created by Gustavo Binder on 03/08/23.
//

import SwiftUI
import GameKit

struct LeaderboardView: View {
    @EnvironmentObject var gcmanager : GCManager
    @EnvironmentObject var sceneManager : SceneManager
    
    @State var entries : [GKLeaderboard.Entry] = []
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        sceneManager.currentScene = .menu
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("menu")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)

            ScrollView {
                if entries.count > 0 {
                    ForEach(Range(0...entries.count - 1), id: \.self) { i in
                        let entry = entries[i]
//                        entry.player.loadPhoto(for: .small)
                        Text("\(entry.rank)º \(entry.player.displayName): \(entry.formattedScore)")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding()
                            .background {
                                Color.white
                                    .opacity(0.78)
                            }
                            .cornerRadius(12)
                            .padding()
                            .transition(.scale)
                    }
                    Text("That's all folks!")
                        .font(.callout)
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background {
                Color.yellow
                    .opacity(0.5)
            }
            .cornerRadius(20)
            .padding()
        }
        .task {
//            await gcmanager.loadLeaderboard()
            entries = await gcmanager.loadEntries()
            print(entries)
        }
    }
}
