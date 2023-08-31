//
//  EndScreen.swift
//  Quiz
//
//  Created by Gustavo Binder on 07/08/23.
//

import SwiftUI

struct EndScreen: View {
    @EnvironmentObject var gcmanager : GCManager
    @EnvironmentObject var sceneManager : SceneManager
    
    @State var points : Int = 0
    @State var originalPoints : Int = 0
    @State var loading : Bool = true
    
    var body: some View {
        VStack {
            if !loading {
                VStack {
                    if originalPoints == points {
                        Image("NormalMonkey")
                    } else if originalPoints > points {
                        Image("SadMonkey")
                            .wiggle(false, 15, 0.2)
                    } else if originalPoints < points {
                        Image("HappyMonkey")
                            .beat(to: CGSize(width: 1.1, height: 1.1))
                    }
                }
                .padding()
                
                Text("Your Score is Now:")
                    .font(.title)
                Text("\(points)")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .wiggle(false, 15, 0.2)
                Button {
                    withAnimation {
                        sceneManager.currentScene = .menu
                    }
                } label: {
                    Text("Menu")
                }
                .padding()
            } else {
                Text("LOADING...")
            }
        }
        .task {
            let entry = await gcmanager.loadLpEntry()
            points = points + entry.score
            originalPoints = entry.score
            gcmanager.submitScore(score: points)
            loading = false
        }
    }
}

struct EndScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndScreen()
    }
}
