//
//  ContentView.swift
//  Quiz
//
//  Created by Gustavo Binder on 31/07/23.
//

import SwiftUI
import GameKit

struct ContentView: View {
    
    @Namespace var namespace
    @EnvironmentObject var gcmanager : GCManager
    @EnvironmentObject var sceneManager : SceneManager
    
    @State var points : Int = 0
    @State var index : Int = 0
    
    @State var pressed : Bool = false
    @State var gotRight : Bool = false
    @State var buttonPressed : Int = -1
    
    @State var localQuestions = questions.shuffled()
    
    @State var transit = false
    
    let localPlayer = GKLocalPlayer.local
    
    private func toNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.spring()) {
                transit = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                withAnimation(.spring()) {
                    if index < localQuestions.count - 1 {
                        index += 1
                        pressed = false
                        transit = false
                        buttonPressed = -1
                    } else {
                        sceneManager.currentScene = .menu
                        gcmanager.submitScore(score: points)
                    }
                    gotRight = false
                }
            }
        }
    }
    
    var body: some View {
        
        let QAUX = localQuestions[index]
        
        VStack {
            HStack {
                HStack {
                    Text("Points: \(points)")
                        .frame(height: 10)
                        .foregroundColor(.white)
                    if pressed {
                        Text(gotRight ? "+10" : "-10")
                            .font(.largeTitle)
                            .foregroundColor(gotRight ? .green : .red)
                            .frame(height: 10)
                            .transition(.scale)
                    }
                }
                .padding()
                .background {
                    Color.black
                        .cornerRadius(8)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        sceneManager.currentScene = .menu
                    }
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 40, height: 40)
                        .padding(8)
                        .background {
                            Color.black
                                .cornerRadius(60)
                        }
                }
                .shadow(radius: 20, x: 20, y: 20)
            }
            Spacer()
            if !transit {
                Text(QAUX.question)
                    .transition(.scale)
                    .padding()
                    .background {
                        Color.black
                            .cornerRadius(8)
                    }
                    .foregroundColor(.white)
                    .padding()
                ForEach(Range(0...QAUX.options.count - 1), id: \.self) { i in
                    Button {
                        if pressed { return }
                        
                        if QAUX.options[i].1 {
                            points += 10
                            gotRight = true
                        } else {
                            points -= 10
                        }
                        
                        buttonPressed = i
                        
                        withAnimation {
                            pressed = true
                        }
                        
                        toNextQuestion()
                        
                    } label: {
                        Text(QAUX.options[i].0)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                if pressed {
                                    if QAUX.options[i].1
                                    {
                                        Color.green
                                    } else {
                                        if buttonPressed == i {
                                            Color.red
                                        } else {
                                            Color.black
                                                .opacity(0.5)
                                                .border(.black)
                                        }
                                    }
                                } else {
                                    Color.black
                                        .opacity(0.5)
                                        .border(.black)
                                }
                            }
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .beat(to: QAUX.options[i].1 == true && pressed ? 0.85 : 1)
                }
            }
            Spacer()
        }
        .padding()
        .background {
            Color.gray
                .opacity(0.5)
                .ignoresSafeArea()
        }
//        .matchedGeometryEffect(id: "game", in: namespace)
        
    }
}
